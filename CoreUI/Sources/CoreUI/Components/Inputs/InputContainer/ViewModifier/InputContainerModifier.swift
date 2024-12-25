//
//  InputContainer.swift
//
//
//  Created by Ivan Pohorielov on 23.01.2024.
//

import SwiftUI

struct InputContainerModifier: ViewModifier {
    
    // MARK: - Properties

    @Binding
    private var text: String
    
    private let state: CoreInputState
    
    private let label: String?
    private let caption: String?
    private let error: String?
    
    // MARK: - Init
    
    init(
        text: Binding<String>,
        state: CoreInputState,
        label: String?,
        caption: String?,
        error: String?
    ) {
        self._text = text
        self.state = state
        self.label = label
        self.caption = caption
        self.error = error
    }
    
    // MARK: - Views
    
    func body(content: Content) -> some View {
        InputContainer(
            text: self._text,
            state: state,
            label: label,
            caption: caption,
            error: error
        ) {
            content
        }
    }
}

extension View {
    
    @warn_unqualified_access
    func inputContainer(
        text: Binding<String>,
        state: CoreInputState,
        label: String?,
        caption: String?,
        error: String?
    ) -> some View {
        modifier(
            InputContainerModifier(
                text: text,
                state: state,
                label: label,
                caption: caption,
                error: error
            )
        )
    }
}
