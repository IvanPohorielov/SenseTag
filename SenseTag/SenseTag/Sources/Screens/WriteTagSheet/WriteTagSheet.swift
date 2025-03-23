//
//  WriteTagSheet.swift
//  SenseTag
//
//  Created by Ivan Pohorielov on 02.02.2025.
//

import ComposableArchitecture
import CoreUI
import FoundationUI
import NFCNDEFManager
import SwiftUI

struct WriteTagSheet: View {

    @Bindable var store: StoreOf<WriteTagFeature>

    @FocusState
    private var isFocused: Bool

    // MARK: - Body

    var body: some View {
        screenView
            .navigationTitle("writeTagSheet.navigationTitle")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        store.send(.dismiss)
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(Color.secondary)
                            .font(.system(size: 20))
                            .opacity(0.8)
                    }
                    .accessibilityLabel("common.closeButton.label")
                    .accessibilityHint("common.closeButton.hint")
                }

                ToolbarItemGroup(placement: .keyboard) {

                    Spacer()  // To move button towards trailng

                    Button {
                        isFocused = false
                    } label: {
                        Image(systemName: "keyboard.chevron.compact.down")
                    }
                    .accessibilityLabel("common.closeKeyboardButton.label")
                    .accessibilityHint("common.closeKeyboardButton.hint")
                }
            }
            .onAppear {
                AccessibilityNotification.ScreenChanged().post()
            }
    }

    // MARK: - Views

    @ViewBuilder
    private var screenView: some View {
        switch store.screenState {
        case .content:
            self.content
        case .error(let message):
            self.error(message)
        case .loading:
            self.loading
        }
    }

    @ViewBuilder
    private var loading: some View {
        ProgressView("common.progressView.title")
            .foregroundStyle(Color.blue.primary)
    }

    @ViewBuilder
    private func error(_ message: String) -> some View {
        PlaceholderScreen {
            Text("writeTagSheet.error.title")
                .font(.senseHOne)
                .accessibilityAddTraits(.isHeader)
                .contentShape(.rect(cornerRadius: .radius4))
        } label: {
            Text(message)
                .font(.senseLabelM)
                .contentShape(.rect(cornerRadius: .radius4))
        } actions: {
            DefaultButton("writeTagSheet.error.action") {
                store.send(.writeToTag)
            }
            .accessibilityHint("writeTagSheet.error.action.hint")
        }
    }

    @ViewBuilder
    private var content: some View {
        VStack {
            Picker("writeTagSheet.picker.title", selection: $store.selectedPayload) {
                ForEach(NFCNDEFWellKnownPayloadType.allCases) { type in
                    Text(type.title)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, -.spacer12)
            .contentShape(.rect(cornerRadius: .radius4))
            .accessibilityHint("writeTagSheet.picker.hint")

            textEditor
        }
        .safeAreaPadding(.horizontal, .spacer16)
        .safeAreaPadding(.bottom, .spacer16)
        .safeAreaInset(edge: .bottom) {
            HStack {
                quickActions
                saveButton
            }
            .disabled(!store.isButtonsEnabled)
            .safeAreaPadding(.horizontal, .spacer16)
            .safeAreaPadding(.bottom, .spacer16)
        }
    }

    @ViewBuilder
    private var textEditor: some View {
        var placeholder: LocalizedStringKey {
            switch store.selectedPayload {
            case .text:
                "writeTagSheet.textEditor.placeholder.text"
            case .url:
                "writeTagSheet.textEditor.placeholder.url"
            }
        }

        var caption: LocalizedStringKey? {
            guard let bytes = store.payloadBytes else { return nil }

            return "writeTagSheet.textEditor.caption \(bytes)"
        }

        DefaultTextEditor(
            $store.text,
            placeholder: placeholder,
            caption: caption
        )
        .scrollDismissesKeyboard(.interactively)
        .defaultTextEditorHeight(nil)
        .focused($isFocused)
    }

    @ViewBuilder
    private var quickActions: some View {
        Group {
            switch store.selectedPayload {
            case .text:
                IconButton(icon: .systemImage("document.on.document.fill")) {
                    store.send(.copyToClipboard)
                }
                .accessibilityLabel("common.copyButton.label")
                .accessibilityHint("common.copyButton.hint")
            case .url:
                IconButton(icon: .systemImage("link")) {
                    store.send(.openURL)
                }
                .accessibilityLabel("common.linkButton.label")
                .accessibilityHint("common.linkButton.hint")
            }
        }
        .iconButtonSize(.large)
    }

    @ViewBuilder
    private var saveButton: some View {
        DefaultButton("writeTagSheet.saveButton.title") {
            store.send(.writeToTag)
        }
        .defaultButtonSize(.large)
        .defaultButtonFullWidth(true)
        .accessibilityHint("common.saveButton.hint")
    }
}

#Preview {
    NavigationStack {
        WriteTagSheet(
            store: Store(
                initialState: WriteTagFeature.State()
            ) {
                WriteTagFeature()
            }
        )
    }
}
