//
//  MainFeature.swift
//  SenseTag
//
//  Created by Ivan Pohorielov on 06.01.2025.
//

import ComposableArchitecture
import SwiftUI
@preconcurrency import AVFoundation
import NFCNDEFManager
import CoreUI

@Reducer
struct MainFeature {
    
    @ObservableState
    struct State {
        @Presents var confirmationDialog: ConfirmationDialogState<Action.ConfirmationDialog>?
        @Presents var alert: AlertState<Action.Alert>?
    }
    
    enum Action {
        case readTapped
        case writeTapped
        case otherTapped
        case confirmationDialog(PresentationAction<ConfirmationDialog>)
        case alert(PresentationAction<Alert>)
        
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
                return .none
            case .writeTapped:
                return .none
            case .otherTapped:
                
                state.confirmationDialog = ConfirmationDialogState {
                    TextState("Other actions")
                } actions: {
                    ButtonState(
                        role: .destructive,
                        action: .lock
                    ) {
                        TextState("Lock")
                    }
                    ButtonState(
                        role: .destructive,
                        action: .clear
                    ) {
                        TextState("Clear")
                    }
                }
                
                return .none
            case .confirmationDialog(let action):
                
                switch action {
                case .presented(let action):
                    state.alert = AlertState {
                        TextState(self.getAlertTitle(action))
                    } actions: {
                        ButtonState(
                            action: self.getAlertAction(action)
                        ) {
                            TextState("Confirm")
                        }
                    } message: {
                        TextState(self.getAlertMessage(action))
                    }
                        
                default:
                    break
                }
                
                return .none
            case .alert(let action):
                
                switch action {
                case .presented(let action):
                    switch action {
                    case .clear:
                        return .run { send in
                            try? await nfcClient.clear()
                        }
                    case .lock:
                        return .run { send in
                            try? await nfcClient.lock()
                        }
                    }
                case .dismiss:
                    return .none
                }
            }
        }
        .ifLet(\.confirmationDialog, action: \.confirmationDialog)
        .ifLet(\.alert, action: \.alert)
    }
}

private extension MainFeature {
    func getAlertTitle(_ action: Action.ConfirmationDialog) -> LocalizedStringKey {
        switch action {
        case .clear:
            return "Clear tag?"
        case .lock:
            return "Lock tag?"
        }
    }
    func getAlertMessage(_ action: Action.ConfirmationDialog) -> LocalizedStringKey {
        switch action {
        case .clear:
            return "Clear action cannot be undone. Are you sure?"
        case .lock:
            return "Lock action cannot be undone. Are you sure?"
        }
    }
    func getAlertAction(_ action: Action.ConfirmationDialog) -> Action.Alert {
        switch action {
        case .clear:
            return .clear
        case .lock:
            return .lock
        }
    }
}
