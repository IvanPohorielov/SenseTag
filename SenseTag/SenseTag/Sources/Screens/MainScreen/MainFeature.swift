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
import SwiftUI

@Reducer
struct MainFeature {
    @ObservableState
    struct State {
        @Presents var confirmationDialog:
            ConfirmationDialogState<Action.ConfirmationDialog>?
        @Presents var alert: AlertState<Action.Alert>?
        @Presents var readTag: ReadTagFeature.State?
    }

    enum Action {
        case readTapped
        case openReadSheet([NFCNDEFManagerPayload])
        case writeTapped
        case otherTapped
        case confirmationDialog(PresentationAction<ConfirmationDialog>)
        case alert(PresentationAction<Alert>)
        case readTag(PresentationAction<ReadTagFeature.Action>)

        enum ConfirmationDialog: Equatable {
            case clear
            case lock
        }

        enum Alert: Equatable {
            case clear
            case lock
        }
    }

    @Dependency(\.nfcClient) var nfcClient

    var body: some ReducerOf<Self> {
        Reduce { state, action in

            switch action {
            case .readTapped:
                return .run { send in
                    guard let payloads = try? await nfcClient.read(),
                        !payloads.isEmpty
                    else {
                        return
                    }
                    await send(.openReadSheet(payloads))
                }
            case let .openReadSheet(payloads):
                state.readTag = ReadTagFeature.State(payloads: payloads)
                return .none
            case .writeTapped:
                return .none
            case .otherTapped:

                state.confirmationDialog = ConfirmationDialogState {
                    TextState("Other actions")
                } actions: {
                    ButtonState(
                        action: .lock
                    ) {
                        TextState("Lock Tag")
                    }
                    ButtonState(
                        action: .clear
                    ) {
                        TextState("Clear Tag")
                    }
                }

                return .none
            case let .confirmationDialog(.presented(action)):

                state.alert = AlertState {
                    TextState(self.getAlertTitle(action))
                } actions: {
                    ButtonState(
                        role: .destructive,
                        action: self.getAlertAction(action)
                    ) {
                        TextState("Confirm")
                    }
                } message: {
                    TextState(self.getAlertMessage(action))
                }

                return .none
            case let .alert(.presented(action)):
                switch action {
                case .clear:
                    return .run { _ in
                        try? await nfcClient.clear()
                    }
                case .lock:
                    return .run { _ in
                        try? await nfcClient.lock()
                    }
                }
            case .readTag(.presented(.dismiss)):
                state.readTag = nil
                return .none
            case .confirmationDialog:
                return .none
            case .alert:
                return .none
            case .readTag:
                return .none
            }
        }
        .ifLet(\.confirmationDialog, action: \.confirmationDialog)
        .ifLet(\.alert, action: \.alert)
        .ifLet(\.$readTag, action: \.readTag) {
            ReadTagFeature()
        }
    }
}

extension MainFeature {
    fileprivate func getAlertTitle(_ action: Action.ConfirmationDialog)
        -> LocalizedStringKey
    {
        switch action {
        case .clear:
            return "Clear tag?"
        case .lock:
            return "Lock tag?"
        }
    }

    fileprivate func getAlertMessage(_ action: Action.ConfirmationDialog)
        -> LocalizedStringKey
    {
        switch action {
        case .clear:
            return "Clear action cannot be undone. Are you sure?"
        case .lock:
            return "Lock action cannot be undone. Are you sure?"
        }
    }

    fileprivate func getAlertAction(_ action: Action.ConfirmationDialog)
        -> Action.Alert
    {
        switch action {
        case .clear:
            return .clear
        case .lock:
            return .lock
        }
    }
}
