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
import UIKit.UIAccessibility

@Reducer
struct ReadTagFeature {
    @ObservableState
    struct State: Equatable {
        var payloads: [NFCNDEFManagerPayload]
    }

    enum Action {
        case dismiss
        case speakUp(NFCNDEFManagerPayload.WellKnownPayload)
        case copyToClipboard(String)
    }
    
    @Dependency(\.dismiss) var dismiss
    @Dependency(\.pasteboard) var pasteboard
    @Dependency(\.speechSynthesizer) var speechSynthesizer

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .dismiss:
                return .run { _ in await self.dismiss() }
            case let .speakUp(payload):
                return .run { _ in
                    await self.speakUp(payload)
                }
            case let .copyToClipboard(text):
                return .run { _ in await self.pasteboard.setString(text) }
            }
        }
    }
}

extension ReadTagFeature {
    fileprivate func speakUp(
        _ payload: NFCNDEFManagerPayload.WellKnownPayload
    ) async {
        switch payload {
        case let .text(text, _):
            await speechSynthesizer.speak(text)
        case let .url(url):
            await speechSynthesizer.speak("URL: \(url)")
        }
    }
}
