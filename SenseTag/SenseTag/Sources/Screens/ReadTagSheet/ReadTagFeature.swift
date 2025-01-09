//
//  ReadTagFeature.swift
//  SenseTag
//
//  Created by Ivan Pohorielov on 08.01.2025.
//

import Foundation
import ComposableArchitecture
import NFCNDEFManager
import AVFoundation

@Reducer
struct ReadTagFeature {
    
    @ObservableState
    struct State: Equatable {
        var payloads: [NFCNDEFManagerPayload]
    }
    
    enum Action {
        case dismiss
        case speakUp(String, Locale)
        case copyToClipboard(String)
        case openURL(URL)
    }
    
    @Dependency(\.openURL) var openURL
    @Dependency(\.dismiss) var dismiss
    @Dependency(\.pasteboard) var pasteboard
    @Dependency(\.speechSynthesizer) var speechSynthesizer
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .dismiss:
                return .run { _ in await self.dismiss() }
            case .speakUp(let text, let locale):
                return .run { _ in
                    let utterance = AVSpeechUtterance(string: text)
                    utterance.prefersAssistiveTechnologySettings = true
                    utterance.voice = AVSpeechSynthesisVoice(identifier: locale.identifier)
                    await speechSynthesizer.speak(utterance)
                }
            case .copyToClipboard(let text):
                return .run { _ in await self.pasteboard.setString(text) }
            case .openURL(let url):
                return .run { _ in await self.openURL(url) }
            }
        }
    }
}
