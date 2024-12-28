//
//  CoreInputClearAction.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 28.12.2024.
//

@MainActor
struct CoreInputClearAction {
    
    private let action: () -> Void

    init(_ action: @escaping @MainActor () -> Void) {
        self.action = action
    }

    // Make the struct callable like a function
    func callAsFunction() {
        action()
    }
}
