//
//  DefaultTextEditorPreview.swift
//  PromUI
//
//  Created by Ivan Pohorielov on 21.10.2024.
//

import FoundationUI
import SwiftUI

#if DEBUG

    @_spi(Preview)
    public struct DefaultTextEditorPreview: View {
        @FocusState
        private var isFocused: Bool

        @State
        private var text: String = ""

        // MARK: - State

        @State
        private var isError: Bool = false
        @State
        private var isDisabled: Bool = false

        // MARK: - Content

        @State
        private var showPlaceholder: Bool = false
        @State
        private var showLabel: Bool = false
        @State
        private var showCaption: Bool = false

        // MARK: - Character Limit Configuration

        @State
        private var enableCharacterLimitConfiguration: Bool = false
        @State
        private var characterLimit: Int = 20
        @State
        private var enableCharacterLimitAppereance: Bool = false
        @State
        private var characterLimitAppereance: Int = 10

        // MARK: - Life cycle

        public init() {}

        // MARK: - Body

        public var body: some View {
            VStack(spacing: 0.0) {
                VStack {
                    Text("DefaultTextEditor")
                        .font(.senseHOne)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Spacer() // Buffer

                    input
                        .focused($isFocused)
                        .disabled(
                            isDisabled
                        )

                    Spacer() // Buffer
                }
                .inputSize(.regular)
                .inputStyle(.regular)
                .inputClearButtonAction {
                    self.text = ""
                }
                .inputCharacterLimitConfiguration(
                    enableCharacterLimitConfiguration ? CoreInputCharacterLimitConfiguration(
                        limit: characterLimit,
                        appearenceLimit: enableCharacterLimitAppereance ? characterLimitAppereance : nil
                    ) : nil
                )
                .defaultTextEditorHeight(142.0)
                .frame(height: 400.0) // Buffer and fixed size make animations work better
                .padding(.horizontal, .spacer24)
                .contentShape(Rectangle())
                .onTapGesture {
                    isFocused = false
                }

                Divider()

                List {
                    stateSection

                    contentSection

                    characterLimitConfigurationSection
                }
            }
        }

        @ViewBuilder
        private var input: some View {
            DefaultTextEditor(
                $text,
                placeholder: showPlaceholder ? "Placeholder" : nil,
                label: showLabel ? "Label" : nil,
                caption: showCaption ? "Caption" : nil,
                error: isError ? "Some error" : nil
            )
        }

        @ViewBuilder
        private var stateSection: some View {
            Section("State") {
                Toggle("Show error", isOn: $isError)
                Toggle("Make disabled", isOn: $isDisabled)
            }
        }

        @ViewBuilder
        private var contentSection: some View {
            Section("Content") {
                Toggle("Show placeholder", isOn: $showPlaceholder)
                Toggle("Show label", isOn: $showLabel)
                Toggle("Show caption", isOn: $showCaption)
            }
        }

        @ViewBuilder
        private var characterLimitConfigurationSection: some View {
            Section("Character limit configuration") {
                Toggle("Enable character limit", isOn: $enableCharacterLimitConfiguration)
                Group {
                    Stepper("Character limit: \(characterLimit)", value: $characterLimit, in: 1 ... 100)
                    Toggle("Show character limit appereance", isOn: $enableCharacterLimitAppereance)
                    Stepper("Character limit appereance: \(characterLimitAppereance)", value: $characterLimitAppereance, in: 1 ... 100)
                        .disabled(!enableCharacterLimitAppereance)
                }
                .disabled(!enableCharacterLimitConfiguration)
            }
        }
    }

    #Preview {
        DefaultTextEditorPreview()
    }

#endif
