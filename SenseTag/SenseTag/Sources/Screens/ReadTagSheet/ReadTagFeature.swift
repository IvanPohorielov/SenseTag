//
//  ReadTagFeature.swift
//  SenseTag
//
//  Created by Ivan Pohorielov on 08.01.2025.
//

import AVFoundation
import ComposableArchitecture
import Foundation
import NFCNDEFManager

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
        Reduce { _, action in
            switch action {
            case .dismiss:
                return .run { _ in await self.dismiss() }
            case let .speakUp(text, locale):
                return .run { _ in
                    let utterance = AVSpeechUtterance(string: text)
                    utterance.prefersAssistiveTechnologySettings = true
                    utterance.voice = AVSpeechSynthesisVoice(identifier: locale.identifier)
                    await speechSynthesizer.speak(utterance)
                }
            case let .copyToClipboard(text):
                return .run { _ in await self.pasteboard.setString(text) }
            case let .openURL(url):
                return .run { _ in await self.openURL(url) }
            }
        }
    }
}
