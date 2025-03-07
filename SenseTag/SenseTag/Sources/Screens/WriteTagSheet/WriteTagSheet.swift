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
        VStack {
            Picker("", selection: $store.selectedPayload) {
                ForEach(NFCNDEFWellKnownPayloadType.allCases) { type in
                    Text(type.title)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, -.spacer12)
            
            textEditor
        }
        .safeAreaPadding(.horizontal, .spacer16)
        .safeAreaPadding(.bottom, .spacer16)
        .safeAreaInset(edge: .bottom) {
            HStack{
                quickActions
                saveButton
            }
            .disabled(!store.isButtonsEnabled)
            .safeAreaPadding(.horizontal, .spacer16)
            .safeAreaPadding(.bottom, .spacer16)
        }
        .navigationTitle("Create Tag")
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
            }
            
            ToolbarItemGroup(placement: .keyboard) {
                
                Spacer() // To move button towards trailng
                
                Button {
                    isFocused = false
                } label: {
                    Image(systemName: "keyboard.chevron.compact.down")
                }
            }
        }
    }
    
    // MARK: - Views
    
    @ViewBuilder
    private var textEditor: some View {
        var placeholder: LocalizedStringKey {
            switch store.selectedPayload {
            case .text:
                "Enter text"
            case .url:
                "Enter URL"
            }
        }
        
        var caption: LocalizedStringKey? {
            guard let bytes = store.payloadBytes else { return nil }
            
            return "Bytes: \(bytes)"
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
                IconButton(icon: .systemImage("waveform")) {
                    store.send(.speakUp)
                }
            case .url:
                IconButton(icon: .systemImage("link")) {
                    store.send(.openURL)
                }
            }
        }
        .iconButtonSize(.large)
    }
    
    @ViewBuilder
    private var saveButton: some View {
        DefaultButton("Write") {
            store.send(.writeToTag)
        }
        .defaultButtonSize(.large)
        .defaultButtonFullWidth(true)
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
