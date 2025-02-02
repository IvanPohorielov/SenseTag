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
    
    //    var store: StoreOf<ReadTagFeature>
    
    @State
    private var selectedPayload: NFCNDEFWellKnownPayloadType = .text
    
    @State
    private var text: String = ""
    
    @FocusState
    private var isFocused: Bool
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            Picker("", selection: $selectedPayload) {
                ForEach(NFCNDEFWellKnownPayloadType.allCases) { type in
                    Text(type.title)
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            DefaultTextEditor(
                text: $text,
                placeholder: "Enter text",
                label: "Label",
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
            switch selectedPayload {
            case .text:
                IconButton {
                    Image(systemName: "waveform")
                } action: {
                    //                store.send(.speakUp(text, locale))
                }
            case .url:
                IconButton {
                    Image(systemName: "link")
                } action: {
                    //                store.send(.openURL(url))
                }
            }
        }
        .iconButtonSize(.large)
    }
    
    @ViewBuilder
    private var saveButton: some View {
        DefaultButton(text: "Save", icon: nil) {
            
        }
        .defaultButtonSize(.large)
        .defaultButtonFullWidth(true)
    }
    
}

extension WriteTagSheet {
    
}

#Preview {
    NavigationStack {
        WriteTagSheet()
    }
}
