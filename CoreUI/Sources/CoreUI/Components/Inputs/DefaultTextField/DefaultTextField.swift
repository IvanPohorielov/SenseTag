//
//  DefaultTextField.swift
//
//
//  Created Ivan Pohorielov on 23.01.2024.
//  Copyright © 2024 Evo.company. All rights reserved.
//

import FoundationUI
import SwiftUI

public struct DefaultTextField<
    Label: View,
    Caption: View,
    ErrorLabel: View,
    Placeholder: View,
    LeftView: View,
    RightView: View
>: View, DefaultTextFieldEnvProtocol {
    // MARK: - Properties

    private let label: Label?
    private let caption: Caption?
    private let error: ErrorLabel?

    private let input: TextField<Placeholder>
    private let leftView: LeftView?
    private let rightView: RightView?

    @Binding
    private var text: String

    private var isError: Bool {
        error != nil
    }

    // MARK: - Env

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

    // MARK: - State

    @State
    private var inputState: CoreInputState = .idle

    @FocusState
    private var isFocused: Bool

    private var leftViewSize: CGFloat {
        UIFontMetrics(forTextStyle: size.fontStyle).scaledValue(
            for: size.leftViewSize)
    }

    private var rightViewSize: CGFloat {
        UIFontMetrics(forTextStyle: size.fontStyle).scaledValue(
            for: size.rightViewSize)
    }

    // MARK: - Views

    public var body: some View {
        HStack(spacing: size.inputStackSpacing) {
            leftView
                .scaledToFit()
                .frame(
                    width: self.leftViewSize,
                    height: self.leftViewSize
                )
                .accessibilityIdentifier(Accessibility.leftView.rawValue)
            textField
            rightView
                .scaledToFit()
                .frame(
                    width: self.rightViewSize,
                    height: self.rightViewSize
                )
                .accessibilityIdentifier(Accessibility.rightView.rawValue)
        }
        .inputContainer(
            text: $text,
            state: inputState,
            label: label,
            caption: caption,
            error: error
        )
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier(Accessibility.DefaultTextField.rawValue)
    }

    private var textField: some View {
        HStack {
            input
                .accessibilityIdentifier(Accessibility.textFieldView.rawValue)

            if self.clearButtonEnabled,
                !self.text.isEmpty,
                self.inputState == .active
            {
                Button {
                    if let clearButtonAction {
                        clearButtonAction()
                    } else {
                        self.text = ""
                    }
                    DefaultHaptics.sendHapticFeedback(.selection)
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.black.shade700)
                }
                .accessibilityIdentifier(Accessibility.clearButton.rawValue)
            }
        }
        .frame(minHeight: size.contentIdealHeight)
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
    }
}

// MARK: - Init

extension DefaultTextField {
    public init(
        _ text: Binding<String>,
        axis: Axis? = nil,
        @ViewBuilder placeholder: () -> Placeholder = { EmptyView?(nil) },
        @ViewBuilder label: () -> Label? = { EmptyView?(nil) },
        @ViewBuilder caption: () -> Caption? = { EmptyView?(nil) },
        @ViewBuilder error: () -> ErrorLabel? = { EmptyView?(nil) },
        @ViewBuilder leftView: () -> LeftView? = { EmptyView?(nil) },
        @ViewBuilder rightView: () -> RightView? = { EmptyView?(nil) }
    ) {
        self._text = text
        if let axis {
            self.input = TextField(text: text, axis: axis, label: placeholder)
        } else {
            self.input = TextField(text: text, label: placeholder)
        }
        self.label = label()
        self.caption = caption()
        self.error = error()
        self.leftView = leftView()
        self.rightView = rightView()
    }
}

extension DefaultTextField
where Placeholder == Text, Label == Text, Caption == Text, ErrorLabel == Text {

    @_semantics("swiftui.init_with_localization")
    public init(
        _ text: Binding<String>,
        axis: Axis? = nil,
        placeholder: LocalizedStringKey? = nil,
        label: LocalizedStringKey? = nil,
        caption: LocalizedStringKey? = nil,
        error: LocalizedStringKey? = nil,
        @ViewBuilder leftView: () -> LeftView? = { EmptyView?(nil) },
        @ViewBuilder rightView: () -> RightView? = { EmptyView?(nil) }
    ) {
        self._text = text
        if let axis {
            self.input = TextField(placeholder ?? "", text: text, axis: axis)
        } else {
            self.input = TextField(placeholder ?? "", text: text)
        }
        self.label = Text(label)
        self.caption = Text(caption)
        self.error = Text(error)
        self.leftView = leftView()
        self.rightView = rightView()
    }

    @_disfavoredOverload
    public init(
        _ text: Binding<String>,
        axis: Axis? = nil,
        placeholder: String? = nil,
        label: String? = nil,
        caption: String? = nil,
        error: String? = nil,
        @ViewBuilder leftView: () -> LeftView? = { EmptyView?(nil) },
        @ViewBuilder rightView: () -> RightView? = { EmptyView?(nil) }
    ) {
        self._text = text
        if let axis {
            self.input = TextField(placeholder ?? "", text: text, axis: axis)
        } else {
            self.input = TextField(placeholder ?? "", text: text)
        }
        
        if let label {
            self.label = Text(label)
        } else {
            self.label = nil
        }
        
        if let caption {
            self.caption = Text(caption)
        } else {
            self.caption = nil
        }
        
        if let error {
            self.error = Text(error)
        } else {
            self.error = nil
        }
        self.leftView = leftView()
        self.rightView = rightView()
    }
}

extension DefaultTextField
where
    Placeholder == Text, Label == Text, Caption == Text, ErrorLabel == Text,
    LeftView == Image, RightView == Image
{

    @_semantics("swiftui.init_with_localization")
    public init(
        _ text: Binding<String>,
        axis: Axis? = nil,
        placeholder: LocalizedStringKey? = nil,
        label: LocalizedStringKey? = nil,
        caption: LocalizedStringKey? = nil,
        error: LocalizedStringKey? = nil,
        leftIcon: ImageContent? = nil,
        rightIcon: ImageContent? = nil
    ) {
        self._text = text
        if let axis {
            self.input = TextField(placeholder ?? "", text: text, axis: axis)
        } else {
            self.input = TextField(placeholder ?? "", text: text)
        }
        self.label = Text(label)
        self.caption = Text(caption)
        self.error = Text(error)
        self.leftView = Image(leftIcon)?.resizable()
        self.rightView = Image(rightIcon)?.resizable()
    }

    @_disfavoredOverload
    public init(
        _ text: Binding<String>,
        axis: Axis? = nil,
        placeholder: String? = nil,
        label: String? = nil,
        caption: String? = nil,
        error: String? = nil,
        leftIcon: ImageResource?,
        rightIcon: ImageResource?
    ) {
        self._text = text
        if let axis {
            self.input = TextField(placeholder ?? "", text: text, axis: axis)
        } else {
            self.input = TextField(placeholder ?? "", text: text)
        }
        
        if let label {
            self.label = Text(label)
        } else {
            self.label = nil
        }
        
        if let caption {
            self.caption = Text(caption)
        } else {
            self.caption = nil
        }
        
        if let error {
            self.error = Text(error)
        } else {
            self.error = nil
        }
        self.leftView = Image(leftIcon)?.resizable()
        self.rightView = Image(rightIcon)?.resizable()
    }
}

#if DEBUG

    #Preview {
        DefaultTextFieldPreview()
    }

#endif
