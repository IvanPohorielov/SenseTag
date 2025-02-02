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
struct TextArea: View {
    // MARK: - Properties

    private let placeholder: String
    private var backgroudColor: Color = .clear

    // MARK: - State

    @Binding var text: String

    // MARK: - Init

    init(
        _ placeholder: String,
        text: Binding<String>
    ) {
        self.placeholder = placeholder
        _text = text
    }

    // MARK: - View

    var body: some View {
        TextEditor(text: $text)
            .introspect(
                .textEditor,
                on: .iOS(.v15...)
            ) { textView in
                textView.backgroundColor = UIColor(backgroudColor)
            }
            .overlay(
                VStack {
                    HStack {
                        text.isEmpty ? Text(placeholder) : Text("")
                        Spacer()
                    }
                    .foregroundColor(
                        .black.primary.opacity(0.38)
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

    // MARK: - TestView

    fileprivate struct TestView: View {
        @State
        var text: String = ""

        var body: some View {
            TextArea("Placeholder", text: $text)
        }
    }

    #Preview {
        TestView()
    }

#endif
