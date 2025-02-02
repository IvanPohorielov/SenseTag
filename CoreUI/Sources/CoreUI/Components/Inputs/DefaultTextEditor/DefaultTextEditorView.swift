//
//  DefaultTextEditorView.swift
//
//
//  Created Ivan Pohorielov on 24.01.2024.
//  Copyright © 2024 Evo.company. All rights reserved.
//

import SwiftUI

public struct DefaultTextEditor: View {
    // MARK: - Properties

    @Binding
    private var text: String
    private let placeholder: String

    private let label: String?
    private let caption: String?
    private let error: String?

    private var isError: Bool {
        error != nil
    }

    // MARK: - State

    @Environment(\.isEnabled)
    private var isEnabled

    @Environment(\.inputClearButtonEnabled)
    var clearButtonEnabled: Bool

    @Environment(\.inputClearButtonAction)
    var clearButtonAction: CoreInputClearAction?

    @Environment(\.inputSize)
    var size: CoreInputSize

    @Environment(\.inputStyle)
    var style: CoreInputStyle

    @Environment(\.defaultTextEditorHeight)
    var editorHeight: CGFloat

    // MARK: - State

    @State
    private var inputState: CoreInputState = .idle

    @FocusState
    private var isFocused: Bool

    // MARK: - Views

    public var body: some View {
        TextArea(
            placeholder,
            text: $text
        )
        .frame(height: editorHeight)
        .foregroundColor(style.foregroundColor(for: inputState))
        .font(size.font)
        .focused($isFocused)
        .onChange(
            of: CoreInputStateWrapper(
                isEnabled: isEnabled,
                isFocused: isFocused,
                isError: isError
            )
        ) { _, wrapper in
            self.inputState = wrapper.getState()
        } // change state according to focus and disabled state
        .onAppear {
            self.inputState = CoreInputStateWrapper(
                isEnabled: isEnabled,
                isFocused: isFocused,
                isError: isError
            ).getState()
        } // initial setup of input state
        .accessibilityIdentifier(Accessibility.textAreaView.rawValue)
        .inputContainer(
            text: $text,
            state: inputState,
            label: label,
            caption: caption,
            error: error
        )
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier(Accessibility.DefaultTextEditor.rawValue)
    }
}

// MARK: - Init

public extension DefaultTextEditor {
    init(
        text: Binding<String>,
        placeholder: String?,
        label: String?,
        caption: String?,
        error: String?
    ) {
        _text = text
        self.placeholder = placeholder ?? ""
        self.label = label
        self.caption = caption
        self.error = error
    }
}

#if DEBUG

    #Preview {
        DefaultTextEditorPreview()
    }

#endif
