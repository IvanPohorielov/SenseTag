//
//  ContentView.swift
//  SenseTag
//
//  Created by Ivan Pohorielov on 09.12.2024.
//

import SwiftUI
import NFCNDEFManager
import AVFoundation

struct ContentView: View {
    // MARK: - You can use either Reader / Writer or both in your application.
    
    @State var msg: String = String(localized: "Scan to read or Edit here to write...")
    
    @State var type: NFCNDEFPayloadType = .text
    
    private let synthesizer = AVSpeechSynthesizer()
    
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
    }
    
    // MARK: - Select NFC Option(s)
    var option: some View {
        HStack {
            
            Picker("Type Picker", selection: $type) {
                // Loop through the enum cases to display options in the Picker
                ForEach(NFCNDEFPayloadType.allCases, id: \.self) { type in
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
        HStack(spacing: 0) {
            Button (action: { read() }) {
                ZStack {
                    Color.pink.opacity(0.85)
                    Label("Read NFC", systemImage: "wave.3.left.circle.fill")
                        .foregroundColor(.white)
                        .padding(.top, 15)
                        .padding(.bottom, 35)
                }
            }
            Button (action: { write() }) {
                ZStack {
                    Color.accentColor.opacity(0.85)
                    Label("Write NFC", systemImage: "wave.3.left.circle.fill")
                        .foregroundColor(.white)
                        .padding(.top, 15)
                        .padding(.bottom, 35)
                }
            }
        }
    }
    
    // MARK: - Sample I/O Functions
    func read() {
        Task {
            do {
                let data = try await NFCNDEFManager().read()
                
                if let payload = data.first {
                    switch payload.type {
                    case .text:
                        let text = try payload.extractText()
                        
                        self.msg = text
                        
                        let utterance = AVSpeechUtterance(string: msg)
                        utterance.prefersAssistiveTechnologySettings = true
                        synthesizer.speak(utterance)
                        
                    case .url:
                        let url = try payload.extractURL()
                        
                        self.msg = url.absoluteString
                    }
                }
            } catch {
                print("Error: \(error)")
            }
            
        }
    }
    func write() {
        Task {
            var payload: NFCNDEFManagerPayload? {
                switch type {
                case .text:
                    return NFCNDEFManagerPayload(text: msg)
                case .url:
                    guard let url = URL(string: msg) else {
                        return nil
                    }
                    return NFCNDEFManagerPayload(url: url)
                }
            }
            
            guard let payload else { return }
            try? await NFCNDEFManager().write(payload)
        }
    }
}


#Preview {
    ContentView()
}
