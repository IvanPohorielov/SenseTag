//
//  MainFeature.swift
//  SenseTag
//
//  Created by Ivan Pohorielov on 06.01.2025.
//

@preconcurrency import AVFoundation
import ComposableArchitecture
import CoreUI
import NFCNDEFManager
import CoreNFC
import SwiftUI

@Reducer
struct MainFeature {
    @ObservableState
    struct State {
        var animate: Bool = false
        @Presents var destination: Destination.State?
    }

    enum Action {
        case readTapped
        case openReadSheet([NFCNDEFManagerPayload])
        case writeTapped
        case otherTapped
        case startAnimation
        case handleError(any Error, Action.Alert)
        case destination(PresentationAction<Destination.Action>)

        enum ConfirmationDialog: Equatable {
            case clear
            case lock
        }

        enum Alert: Equatable {
            case clear
            case lock
            case read
        }
    }

    @Dependency(\.nfcClient) var nfcClient

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .readTapped:
                return handleReadTapped(state: &state)
            case let .openReadSheet(payloads):
                return openReadSheet(state: &state, payloads: payloads)
            case .writeTapped:
                return handleWriteTapped(state: &state)
            case .otherTapped:
                return handleOtherTapped(state: &state)
            case let .destination(.presented(.confirmationDialog(action))):
                return handleConfirmationDialog(action, state: &state)
            case let .destination(.presented(.alert(action))):
                return handleAlertAction(action)
            case .startAnimation:
                state.animate = true
                return .none
            case .handleError(let error, let action):
                return handleNFCManagerError(error, action: action, state: &state)
            case .destination:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
    
    private func handleReadTapped(state: inout State) -> Effect<Action> {
        return .run { send in
            do {
                let payloads = try await nfcClient.read()
                guard !payloads.isEmpty else { return }
                await send(.openReadSheet(payloads))
            } catch {
                await send(.handleError(error, .read))
            }
        }
    }

    private func openReadSheet(state: inout State, payloads: [NFCNDEFManagerPayload]) -> Effect<Action> {
        state.destination = .readTag(ReadTagFeature.State(payloads: payloads))
        return .none
    }

    private func handleWriteTapped(state: inout State) -> Effect<Action> {
        state.destination = .writeTag(WriteTagFeature.State())
        return .none
    }

    private func handleOtherTapped(state: inout State) -> Effect<Action> {
        state.destination = .confirmationDialog(
            ConfirmationDialogState { TextState("mainScreen.dialog.otherActions") }
            actions: {
                ButtonState(action: .lock) { TextState("mainScreen.dialog.action.lockTag") }
                ButtonState(action: .clear) { TextState("mainScreen.dialog.action.clearTag") }
            }
        )
        return .none
    }

    private func handleConfirmationDialog(_ action: Action.ConfirmationDialog, state: inout State) -> Effect<Action> {
        state.destination = .alert(
            AlertState {
                TextState(getAlertTitle(action))
            }
            actions: {
                ButtonState(role: .destructive, action: getAlertAction(action)) {
                    TextState("mainScreen.alert.action.confirm")
                }
            } message: {
                TextState(getAlertMessage(action))
            }
        )
        return .none
    }

    private func handleAlertAction(_ action: Action.Alert) -> Effect<Action> {
        .run { send in
            do {
                switch action {
                case .clear:
                    try await nfcClient.clear()
                case .lock:
                    try await nfcClient.lock()
                case .read:
                    await send(.readTapped)
                }
            } catch {
                await send(.handleError(error, action))
            }
        }
    }
    
    private func handleNFCManagerError(_ error: any Error, action: Action.Alert, state: inout State) -> Effect<Action> {
        state.destination = .alert(
            AlertState {
                TextState("mainScreen.alert.error.title")
            }
            actions: {
                ButtonState(action: action) {
                    TextState("mainScreen.alert.error.tryAgain")
                }
                ButtonState(role: .cancel) {
                    TextState("common.cancel")
                }
            } message: {
                switch error {
                case let nfcError as NFCError :
                    TextState(String(localized: nfcError.localizedString))
                case let nfcReaderError as NFCReaderError:
                    TextState(String(localized: nfcReaderError.localizedString))
                default:
                    TextState(error.localizedDescription)
                }
            }
        )
        return .none
    }
}

extension MainFeature {
    @Reducer
    enum Destination {
        case confirmationDialog(ConfirmationDialogState<MainFeature.Action.ConfirmationDialog>)
        case alert(AlertState<MainFeature.Action.Alert>)
        case readTag(ReadTagFeature)
        case writeTag(WriteTagFeature)
    }
}

// Utility functions
extension MainFeature {
    private func getAlertTitle(_ action: Action.ConfirmationDialog) -> LocalizedStringKey {
        switch action {
        case .clear: return "mainScreen.alert.title.clearTag"
        case .lock: return "mainScreen.alert.title.lockTag"
        }
    }

    private func getAlertMessage(_ action: Action.ConfirmationDialog) -> LocalizedStringKey {
        switch action {
        case .clear: return "mainScreen.alert.message.clearTag"
        case .lock: return "mainScreen.alert.message.lockTag"
        }
    }

    private func getAlertAction(_ action: Action.ConfirmationDialog) -> Action.Alert {
        switch action {
        case .clear: return .clear
        case .lock: return .lock
        }
    }
}

