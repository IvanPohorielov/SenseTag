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
        var animate: Bool = false
        @Presents var destination: Destination.State?
    }

    enum Action {
        case readTapped
        case openReadSheet([NFCNDEFManagerPayload])
        case writeTapped
        case otherTapped
        case startAnimation
        case destination(PresentationAction<Destination.Action>)

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
                state.destination = .readTag(
                    ReadTagFeature.State(payloads: payloads))
                return .none
            case .writeTapped:
                state.destination = .writeTag(WriteTagFeature.State())
                return .none
            case .otherTapped:

                state.destination = .confirmationDialog(
                    ConfirmationDialogState {
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
                )

                return .none
            case let .destination(.presented(.confirmationDialog(action))):

                state.destination = .alert(
                    AlertState {
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
                )

                return .none
            case let .destination(.presented(.alert(action))):
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
            case .startAnimation:
                state.animate = true
                return .none
            case .destination:
                    return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}

extension MainFeature {
    @Reducer
    enum Destination {
        case confirmationDialog(
            ConfirmationDialogState<MainFeature.Action.ConfirmationDialog>)
        case alert(AlertState<MainFeature.Action.Alert>)
        case readTag(ReadTagFeature)
        case writeTag(WriteTagFeature)
    }
}

//extension MainFeature.Destination.State: Equatable {}

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
