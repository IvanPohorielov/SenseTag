//
//  CoreInputStateWrapper.swift
//  PromUI
//
//  Created by Ivan Pohorielov on 18.10.2024.
//

import Foundation

struct CoreInputStateWrapper: Hashable, Sendable {
    let isEnabled: Bool
    let isFocused: Bool
    let isError: Bool

    init(
        isEnabled: Bool,
        isFocused: Bool,
        isError: Bool
    ) {
        self.isEnabled = isEnabled
        self.isFocused = isFocused
        self.isError = isError
    }
}

extension CoreInputStateWrapper {
    func getState() -> CoreInputState {
        guard isEnabled else { return .disabled }
        guard !isError else { return .error }

        if isFocused {
            return .active
        } else {
            return .idle
        }
    }
}
