//
//  ButtonCoreState.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 18.12.2024.
//

import protocol SwiftUI.ButtonStyle


enum ButtonCoreState: String, Hashable, CaseIterable, Sendable {
    case idle
    case pressed
    case disabled
}

extension ButtonCoreState {
    static func getState(
        from configuration: ButtonStyle.Configuration,
        isEnabled: Bool
    ) -> ButtonCoreState {
        if !isEnabled {
            return .disabled
        } else if configuration.isPressed {
            return .pressed
        }
        return .idle
    }
}
