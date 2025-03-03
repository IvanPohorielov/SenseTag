//
//  DefaultTextEditorView.swift
//
//
//  Created Ivan Pohorielov on 24.01.2024.
//  Copyright © 2024 Evo.company. All rights reserved.
//

import SwiftUI
import FoundationUI

public struct DefaultTextEditor<
    Label: View,
    Caption: View,
    ErrorLabel: View,
    Placeholder: View
>: View {
    // MARK: - Properties

    private let label: Label?
    private let caption: Caption?
    private let error: ErrorLabel?
    private let placeholder: Placeholder?

    private let editor: TextEditor

    @Binding
    private var text: String

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
    var editorHeight: CGFloat?

    // MARK: - State

    @State
    private var inputState: CoreInputState = .idle

    @FocusState
    private var isFocused: Bool

    // MARK: - Views

    public var body: some View {
        TextArea(
            placeholder: placeholder,
            editor: editor,
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
        }  // change state according to focus and disabled state
        .onAppear {
            self.inputState = CoreInputStateWrapper(
                isEnabled: isEnabled,
                isFocused: isFocused,
                isError: isError
            ).getState()
        }  // initial setup of input state
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

extension DefaultTextEditor {
    public init(
        _ text: Binding<String>,
        @ViewBuilder placeholder: () -> Placeholder = { EmptyView?(nil) },
        @ViewBuilder label: () -> Label = { EmptyView?(nil) },
        @ViewBuilder caption: () -> Caption = { EmptyView?(nil) },
        @ViewBuilder error: () -> ErrorLabel = { EmptyView?(nil) }
    ) {
        self._text = text
        self.editor = TextEditor(text: text)
        self.placeholder = placeholder()
        self.label = label()
        self.caption = caption()
        self.error = error()
    }
}

extension DefaultTextEditor
where Placeholder == Text, Label == Text, Caption == Text, ErrorLabel == Text {

    @_semantics("swiftui.init_with_localization")
    public init(
        _ text: Binding<String>,
        placeholder: LocalizedStringKey? = nil,
        label: LocalizedStringKey? = nil,
        caption: LocalizedStringKey? = nil,
        error: LocalizedStringKey? = nil
    ) {
        self._text = text
        self.editor = TextEditor(text: text)
        self.placeholder = Text(placeholder)
        self.label = Text(label)
        self.caption = Text(caption)
        self.error = Text(error)
    }

    @_disfavoredOverload
    public init(
        _ text: Binding<String>,
        placeholder: String? = nil,
        label: String? = nil,
        caption: String? = nil,
        error: String? = nil
    ) {
        self._text = text
        self.editor = TextEditor(text: text)
        self.placeholder = Text(placeholder)
        self.label = Text(label)
        self.caption = Text(caption)
        self.error = Text(error)
    }
}

#if DEBUG

    #Preview {
        DefaultTextEditorPreview()
    }

#endif
