//
//  TextArea.swift
//
//
//  Created by Ivan Pohorielov on 24.01.2024.
//

import FoundationUI
import SwiftUI
@_spi(Advanced) import SwiftUIIntrospect

/// Temporary solution, untill Apple add palceholder
struct TextArea<
    Placeholder: View
>: View {
    // MARK: - Properties

    private let placeholder: Placeholder?
    private let editor: TextEditor
    private var backgroudColor: Color = .clear

    // MARK: - State

    @Binding var text: String

    // MARK: - Init

    init(
        placeholder: Placeholder?,
        editor: TextEditor,
        text: Binding<String>
    ) {
        self.placeholder = placeholder
        self.editor = editor
        self._text = text
    }

    // MARK: - View

    var body: some View {
        editor
            .introspect(
                .textEditor,
                on: .iOS(.v15...)
            ) { textView in
                textView.backgroundColor = UIColor(backgroudColor)
            }
            .overlay(
                VStack {
                    HStack {
                        text.isEmpty ? AnyView(placeholder) : AnyView(EmptyView())
                        Spacer()
                    }
                    .foregroundColor(
                        Color(UIColor.placeholderText)
                    )
                    .padding(
                        EdgeInsets(
                            top: 7.0,
                            leading: 4.0,
                            bottom: 0.0,
                            trailing: 0.0
                        )
                    )
                    Spacer()
                }
            )
    }

    public func backgroundColor(_ color: Color) -> Self {
        var copy = self
        copy.backgroudColor = color
        return copy
    }
}

#if DEBUG

    #Preview {
        @Previewable @State
        var text: String = ""
        
        TextArea(
            placeholder: Text("Hello"),
            editor: TextEditor(text: $text),
            text: $text
        )
    }

#endif
