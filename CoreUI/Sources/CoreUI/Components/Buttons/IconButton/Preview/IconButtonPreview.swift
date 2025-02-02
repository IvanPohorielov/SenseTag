//
//  IconButtonPreview.swift
//  PromUI
//
//  Created by Ivan Pohorielov on 21.10.2024.
//

import FoundationUI
import SwiftUI

#if DEBUG

    @_spi(Preview)
    public struct IconButtonPreview: View {
        // MARK: - State

        @State
        private var isLoading: Bool = false
        @State
        private var isDisabled: Bool = false

        // MARK: - Configuration

        @State
        private var size: IconButtonSize = .regular

        @State
        private var style: IconButtonStyle = .secondary

        @State
        private var borderShage: CoreButtonBorderShape = .roundedRectangle

        // MARK: - Life cycle

        public init() {}

        // MARK: - Body

        public var body: some View {
            VStack(spacing: 0.0) {
                VStack {
                    Text("IconButton")
                        .font(.senseHOne)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Spacer() // Buffer

                    button
                        .animation(.default, value: isLoading)
                        .animation(.default, value: isDisabled)
                        .animation(.default, value: size)
                        .animation(.default, value: style)
                        .animation(.default, value: borderShage)

                    Spacer() // Buffer
                }
                .iconButtonSize(size)
                .iconButtonStyle(style)
                .iconButtonBorderShape(borderShage)
                .isLoading(isLoading)
                .disabled(isDisabled)
                .frame(height: 200.0)
                .padding(.horizontal, .spacer24)

                Divider()

                List {
                    stateSection

                    configurationSection
                }
            }
        }

        @ViewBuilder
        private var button: some View {
            IconButton(
                icon: .systemImage("microphone")
            ) {
                DefaultHaptics.sendHapticFeedback(.selection)
            }
        }

        @ViewBuilder
        private var stateSection: some View {
            Section("State") {
                Toggle("Show loading", isOn: $isLoading)
                Toggle("Make disabled", isOn: $isDisabled)
            }
        }

        @ViewBuilder
        private var configurationSection: some View {
            Section("Configuration") {
                VStack {
                    Text("Bornder shape")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Picker("", selection: $borderShage) {
                        ForEach(CoreButtonBorderShape.allCases, id: \.self) {
                            switch $0 {
                            case .roundedRectangle:
                                Text("Rounded rectangle")
                            case .capsule:
                                Text("Capsule")
                            }
                        }
                    }
                    .pickerStyle(.segmented)
                }

                VStack {
                    HStack {
                        Text("Style")
                            .frame(maxWidth: .infinity)
                        Text("Size")
                            .frame(maxWidth: .infinity)
                    }
                    HStack {
                        Picker("", selection: $style) {
                            ForEach(IconButtonStyle.allCases, id: \.self) {
                                switch $0 {
                                case .primary:
                                    Text("Primary")
                                case .secondary:
                                    Text("Secondary")
                                case .tertiary:
                                    Text("Tertiary")
                                default:
                                    Text("None")
                                }
                            }
                        }
                        .pickerStyle(.wheel)

                        Picker("", selection: $size) {
                            ForEach(IconButtonSize.allCases, id: \.self) {
                                switch $0 {
                                case .large:
                                    Text("Large")
                                case .regular:
                                    Text("Regular")
                                case .compact:
                                    Text("Compact")
                                default:
                                    Text("None")
                                }
                            }
                        }
                        .pickerStyle(.wheel)
                    }
                }
                .frame(height: 150)
            }
        }
    }

    #Preview {
        IconButtonPreview()
    }

#endif
