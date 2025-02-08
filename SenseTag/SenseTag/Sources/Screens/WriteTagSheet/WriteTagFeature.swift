//
//  WriteTag.swift
//  SenseTag
//
//  Created by Ivan Pohorielov on 05.02.2025.
//

import AVFoundation
import ComposableArchitecture
import Foundation
import NFCNDEFManager

@Reducer
struct WriteTagFeature {
    @ObservableState
    struct State: Equatable {
        var selectedPayload: NFCNDEFWellKnownPayloadType = .text
        var text: String = ""
    }

    enum Action: BindableAction {
        case dismiss
        case binding(BindingAction<State>)
        case writeToTag
        case speakUp
        case openURL
    }

    @Dependency(\.openURL) var openURL
    @Dependency(\.dismiss) var dismiss
    @Dependency(\.pasteboard) var pasteboard
    @Dependency(\.languageRecognizer) var languageRecognizer
    @Dependency(\.speechSynthesizer) var speechSynthesizer

    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .dismiss:
                return .run { _ in await self.dismiss() }
            case .speakUp:
                return .run { [state] _ in
                    await speechSynthesizer.speak(state.text)
                }
            case .openURL:
//                return .run { _ in await self.openURL(url) }
                return .none
            case .writeToTag:
                return .none
            case .binding:
                return .none
            }
        }
    }
}
