//
//  DefaultTextField.swift
//
//
//  Created Ivan Pohorielov on 23.01.2024.
//  Copyright © 2024 Evo.company. All rights reserved.
//

import SwiftUI
import FoundationUI

public struct DefaultTextField<LeftView: View, RightView: View>: View, DefaultTextFieldEnvProtocol {
    
    // MARK: - Properties
    
    private let leftView: LeftView?
    
    private let rightView: RightView?
    
    @Binding
    private var text: String
    private let placeholder: String
    
    private let label: String?
    private let caption: String?
    private let error: String?
    
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
    
    @ScaledMetric
    var leftViewSize: CGFloat = 0.0
    
    @ScaledMetric
    var rightViewSize: CGFloat = 0.0
    
    // MARK: - Views
    
    public var body : some View {
        HStack(spacing: size.inputStackSpacing) {
            leftView
                .frame(
                    width: self.leftViewSize,
                    height: self.leftViewSize
                )
                .accessibilityIdentifier(Accessibility.leftView.rawValue)
            textField
            rightView
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
            
            TextField(
                self.placeholder,
                text: self.$text
            )
            .accessibilityIdentifier(Accessibility.textFieldView.rawValue)
            
            if self.clearButtonEnabled,
               !self.text.isEmpty,
               self.inputState == .active {
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
                isEnabled: self.isEnabled,
                isFocused: self.isFocused,
                isError: self.isError
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
    }
}

// MARK: - Init

public extension DefaultTextField {
    init(
        text: Binding<String>,
        placeholder: String?,
        label: String?,
        caption: String?,
        error: String?,
        @ViewBuilder leftView: () -> (LeftView) = { EmptyView?(nil) },
        @ViewBuilder rightView: () -> (RightView) = { EmptyView?(nil) }
    ) {
        self._text = text
        self.placeholder = placeholder ?? ""
        self.label = label
        self.caption = caption
        self.error = error
        self.leftView = leftView()
        self.rightView = rightView()
        
        self._leftViewSize = ScaledMetric(wrappedValue: self.size.leftViewSize, relativeTo: self.size.fontStyle)
        self._rightViewSize = ScaledMetric(wrappedValue: self.size.rightViewSize, relativeTo: self.size.fontStyle)
    }
}

#if DEBUG

#Preview {
    DefaultTextFieldPreview()
}

#endif
