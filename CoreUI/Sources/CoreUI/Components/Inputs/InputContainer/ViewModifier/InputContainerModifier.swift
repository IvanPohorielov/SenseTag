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
        @ViewBuilder label: () -> Label = { EmptyView?(nil) },
        @ViewBuilder caption: () -> Caption = { EmptyView?(nil) },
        @ViewBuilder error: () -> ErrorLabel = { EmptyView?(nil) }
    ) {
        _text = text
        self.state = state
        self.label = label()
        self.caption = caption()
        self.error = error()
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

extension InputContainerModifier where Label == Text, Caption == Text, ErrorLabel == Text {
    
    @_semantics("swiftui.init_with_localization")
    init(
        _ text: Binding<String>,
        state: CoreInputState,
        labelKey: LocalizedStringKey? = nil,
        captionKey: LocalizedStringKey? = nil,
        errorKey: LocalizedStringKey? = nil
    ) {
        _text = text
        self.state = state
        
        if let labelKey {
            self.label = Text(labelKey)
        } else {
            self.label = nil
        }
        
        if let captionKey {
            self.caption = Text(captionKey)
        } else {
            self.caption = nil
        }
        
        if let errorKey {
            self.error = Text(errorKey)
        } else {
            self.error = nil
        }
    }
    
    @_disfavoredOverload
    init<L, C, E>(
        _ text: Binding<String>,
        state: CoreInputState,
        label: L? = nil,
        caption: C? = nil,
        error: E? = nil
    ) where L : StringProtocol, C : StringProtocol, E : StringProtocol {
        _text = text
        self.state = state
        
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
    }
}

extension View {
    func inputContainer<Label: View, Caption: View, ErrorLabel: View>(
        text: Binding<String>,
        state: CoreInputState,
        @ViewBuilder label: () -> Label = { EmptyView() },
        @ViewBuilder caption: () -> Caption = { EmptyView() },
        @ViewBuilder error: () -> ErrorLabel = { EmptyView() }
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
    
    func inputContainer(
        text: Binding<String>,
        state: CoreInputState,
        label: LocalizedStringKey? = nil,
        caption: LocalizedStringKey? = nil,
        error: LocalizedStringKey? = nil
    ) -> some View {
        modifier(
            InputContainerModifier(
                text,
                state: state,
                labelKey: label,
                captionKey: caption,
                errorKey: error
            )
        )
    }
    
    func inputContainer<L: StringProtocol, C: StringProtocol, E: StringProtocol>(
        text: Binding<String>,
        state: CoreInputState,
        label: L? = nil,
        caption: C? = nil,
        error: E? = nil
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
