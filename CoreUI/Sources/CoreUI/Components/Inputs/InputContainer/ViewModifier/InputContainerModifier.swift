//
//  InputContainerModifier.swift
//
//
//  Created by Ivan Pohorielov on 23.01.2024.
//

import SwiftUI

struct InputContainerModifier<
    Label: View,
    Caption: View,
    ErrorLabel: View
>: ViewModifier {
    private let label: Label?
    private let caption: Caption?
    private let error: ErrorLabel?

    @Binding
    private var text: String

    private let state: CoreInputState
    
    // MARK: - Init
    
    init(
        _ text: Binding<String>,
        state: CoreInputState,
        label: Label?,
        caption: Caption?,
        error: ErrorLabel?
    ) {
        _text = text
        self.state = state
        self.label = label
        self.caption = caption
        self.error = error
    }

    // MARK: - Views

    func body(content: Content) -> some View {
        InputContainer(
            _text,
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
    func inputContainer<Label: View, Caption: View, ErrorLabel: View>(
        text: Binding<String>,
        state: CoreInputState,
        label: Label?,
        caption: Caption?,
        error: ErrorLabel?
    ) -> some View {
        modifier(
            InputContainerModifier(
                text,
                state: state,
                label: label,
                caption: caption,
                error: error
            )
        )
    }
}
