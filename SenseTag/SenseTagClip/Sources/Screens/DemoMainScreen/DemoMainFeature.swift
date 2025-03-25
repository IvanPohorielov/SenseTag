//
//  MainFeature.swift
//  SenseTag
//
//  Created by Ivan Pohorielov on 06.01.2025.
//

@preconcurrency import AVFoundation
import ComposableArchitecture
import CoreUI
import CoreDependencies
import NFCNDEFManager
import CoreNFC
import SwiftUI

@Reducer
struct DemoMainFeature {
    @ObservableState
    struct State {
        @Presents var destination: Destination.State?
    }

    enum Action {
        case readTapped
        case openReadSheet([NFCNDEFManagerPayload])
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

extension DemoMainFeature {
    @Reducer
    enum Destination {
        case alert(AlertState<DemoMainFeature.Action.Alert>)
        case readTag(ReadTagFeature)
    }
}

