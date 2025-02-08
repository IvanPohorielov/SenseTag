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
            DefaultTextEditor(
                text: $store.text,
                placeholder: "Enter text",
                caption: "Caption",
                error: nil
            )
            .scrollDismissesKeyboard(.interactively)
            .defaultTextEditorHeight(nil)
            .focused($isFocused)
        }
        .safeAreaPadding(.horizontal, .spacer16)
        .safeAreaPadding(.bottom, .spacer16)
        .safeAreaInset(edge: .bottom) {
            HStack{
                quickActions
                saveButton
            }
            .safeAreaPadding(.horizontal, .spacer16)
            .safeAreaPadding(.bottom, .spacer16)
        }
        .navigationTitle("Write Tag")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
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
    private var quickActions: some View {
        Group {
            switch store.selectedPayload {
            case .text:
                IconButton {
                    Image(systemName: "waveform")
                } action: {
                    store.send(.speakUp)
                }
            case .url:
                IconButton {
                    Image(systemName: "link")
                } action: {
                    store.send(.openURL)
                }
            }
        }
        .iconButtonSize(.large)
    }
    
    @ViewBuilder
    private var saveButton: some View {
        DefaultButton(text: "Save", icon: nil) {
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
