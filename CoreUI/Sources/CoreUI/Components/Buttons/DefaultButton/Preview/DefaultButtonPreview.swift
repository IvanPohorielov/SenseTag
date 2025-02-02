//
//  DefaultButtonPreview.swift
//  PromUI
//
//  Created by Ivan Pohorielov on 21.10.2024.
//

import FoundationUI
import SwiftUI

#if DEBUG

    @_spi(Preview)
    public struct DefaultButtonPreview: View {
        // MARK: - State

        @State
        private var isLoading: Bool = false
        @State
        private var isDisabled: Bool = false

        // MARK: - Content

        @State
        private var isShowIcon: Bool = false

        // MARK: - Configuration

        @State
        private var size: DefaultButtonSize = .regular

        @State
        private var style: DefaultButtonStyle = .secondary

        @State
        private var borderShage: CoreButtonBorderShape = .roundedRectangle

        @State
        private var isFullWidht: Bool = false

        // MARK: - Life cycle

        public init() {}

        // MARK: - Body

        public var body: some View {
            VStack(spacing: 0.0) {
                VStack {
                    Text("DefaultButton")
                        .font(.senseHOne)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Spacer() // Buffer

                    button
                        .animation(.default, value: isLoading)
                        .animation(.default, value: isDisabled)
                        .animation(.default, value: isShowIcon)
                        .animation(.default, value: size)
                        .animation(.default, value: style)
                        .animation(.default, value: borderShage)
                        .animation(.default, value: isFullWidht)

                    Spacer() // Buffer
                }
                .defaultButtonSize(size)
                .defaultButtonStyle(style)
                .defaultButtonBorderShape(borderShage)
                .defaultButtonFullWidth(isFullWidht)
                .isLoading(isLoading)
                .disabled(isDisabled)
                .frame(height: 200.0)
                .padding(.horizontal, .spacer24)

                Divider()

                List {
                    stateSection

                    contentSection

                    configurationSection
                }
            }
        }

        @ViewBuilder
        private var button: some View {
            DefaultButton(
                text: "Button",
                icon: isShowIcon ? .systemImage("xmark") : nil
            ) {
                
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
        private var contentSection: some View {
            Section("Content") {
                Toggle("Show icon", isOn: $isShowIcon)
            }
        }

        @ViewBuilder
        private var configurationSection: some View {
            Section("Configuration") {
                Toggle("Make full width", isOn: $isFullWidht)

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
                            ForEach(DefaultButtonStyle.allCases, id: \.self) {
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
                            ForEach(DefaultButtonSize.allCases, id: \.self) {
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
        DefaultButtonPreview()
    }

#endif
