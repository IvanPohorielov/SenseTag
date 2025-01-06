//
//  ContentView.swift
//  SenseTag
//
//  Created by Ivan Pohorielov on 09.12.2024.
//

import SwiftUI
import NFCNDEFManager
import ComposableArchitecture

struct ContentView: View {
    // MARK: - You can use either Reader / Writer or both in your application.
    
    @Bindable var store: StoreOf<MainFeature>

    
    @State var msg: String = String(localized: "Scan to read or Edit here to write...")
    
    @State var type: NFCNDEFWellKnownPayloadType = .text
    
    @FocusState
    var isFocused: Bool
    
    // MARK: - Editor for I/O Message
    var editor: some View {
        TextEditor(text: $msg)
            .font(.title)
            .padding(.top, 50)
            .padding(15)
            .background(Color.accentColor.opacity(0.5))
            .focused($isFocused)
    }
    
    // MARK: - Main App Content
    var body: some View {
        VStack(spacing: 0) {
            option
            editor
        }
        .onTapGesture {
            self.isFocused = false
        }
        .safeAreaInset(edge: .bottom) {
            action
                .frame(height: 75)
        }
        .alert($store.scope(state: \.alert, action: \.alert))
        .confirmationDialog($store.scope(state: \.confirmationDialog, action: \.confirmationDialog))
    }
    
    // MARK: - Select NFC Option(s)
    var option: some View {
        HStack {
            
            Picker("Type Picker", selection: $type) {
                // Loop through the enum cases to display options in the Picker
                ForEach(NFCNDEFWellKnownPayloadType.allCases, id: \.self) { type in
                    Text(type.title).tag(type)
                }
            }
            Spacer()
            Button("Close Keyboard") {
                self.isFocused = false
            }
        }.padding(.horizontal)
    }
    
    // MARK: - Action Buttons
    var action: some View {
        VStack(spacing: 0) {
            Button (action: { store.send(.otherTapped) }) {
                ZStack {
                    Color.black.opacity(0.85)
                    Label("Other actions", systemImage: "lock.circle.fill")
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                }
            }
            HStack(spacing: 0) {
                Button (action: { store.send(.readTapped) }) {
                    ZStack {
                        Color.green.opacity(0.85)
                        Label("Read NFC", systemImage: "wave.3.left.circle.fill")
                            .foregroundColor(.white)
                            .padding(.top, 15)
                            .padding(.bottom, 35)
                    }
                }
                Button (action: {
                    var payload: NFCNDEFManagerPayload? {
                        switch type {
                        case .text:
                            return .wellKnown(.text(msg, Locale.current))
                        case .url:
                            guard let url = URL(string: msg) else {
                                return nil
                            }
                            return .wellKnown(.url(url))
                        }
                    }
                    
                    guard let payload else { return }
                    
                    store.send(.writeTapped)
                }) {
                    ZStack {
                        Color.blue.opacity(0.85)
                        Label("Write NFC", systemImage: "wave.3.left.circle.fill")
                            .foregroundColor(.white)
                            .padding(.top, 15)
                            .padding(.bottom, 35)
                    }
                }
            }
        }
    }
}


#Preview {
    ContentView(
        store: Store(initialState: MainFeature.State()) {
            MainFeature()
        }
      )
}
