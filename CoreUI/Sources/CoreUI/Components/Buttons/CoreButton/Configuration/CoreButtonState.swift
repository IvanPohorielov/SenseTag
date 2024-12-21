//
//  CoreButtonState.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 18.12.2024.
//

import protocol SwiftUI.ButtonStyle


enum CoreButtonState: String, Hashable, CaseIterable, Sendable {
    case idle
    case pressed
    case disabled
}

extension CoreButtonState {
    static func getState(
        from configuration: ButtonStyle.Configuration,
        isEnabled: Bool
    ) -> CoreButtonState {
        if !isEnabled {
            return .disabled
        } else if configuration.isPressed {
            return .pressed
        }
        return .idle
    }
}
