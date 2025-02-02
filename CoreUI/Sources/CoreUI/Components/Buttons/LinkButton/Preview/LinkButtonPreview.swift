//
//  LinkButtonPreview.swift
//  PromUI
//
//  Created by Ivan Pohorielov on 21.10.2024.
//

import FoundationUI
import SwiftUI

#if DEBUG

    @_spi(Preview)
    public struct LinkButtonPreview: View {
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
        private var size: LinkButtonSize = .regular

        @State
        private var style: LinkButtonStyle = .regular

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
                    Text("LinkButton")
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
                .linkButtonSize(size)
                .linkButtonStyle(style)
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
            LinkButton(
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
                VStack {
                    HStack {
                        Text("Style")
                            .frame(maxWidth: .infinity)
                        Text("Size")
                            .frame(maxWidth: .infinity)
                    }
                    HStack {
                        Picker("", selection: $style) {
                            ForEach(LinkButtonStyle.allCases, id: \.self) {
                                switch $0 {
                                case .regular:
                                    Text("Regular")
                                default:
                                    Text("None")
                                }
                            }
                        }
                        .pickerStyle(.wheel)

                        Picker("", selection: $size) {
                            ForEach(LinkButtonSize.allCases, id: \.self) {
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
        LinkButtonPreview()
    }

#endif
