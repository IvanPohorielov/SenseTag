//
//  WriteTag.swift
//  SenseTag
//
//  Created by Ivan Pohorielov on 05.02.2025.
//

import ComposableArchitecture
import Foundation
import NFCNDEFManager

@Reducer
struct WriteTagFeature {
    @ObservableState
    struct State: Equatable {
        var selectedPayload: NFCNDEFWellKnownPayloadType = .text
        var text: String = ""
        var payloadBytes: Int? = nil
        var isButtonsEnabled: Bool = false
    }

    enum Action: BindableAction {
        case dismiss
        case binding(BindingAction<State>)
        case writeToTag
        case speakUp
        case openURL
        case updatePayloadBytes(Int?)
    }

    @Dependency(\.openURL) var openURL
    @Dependency(\.dismiss) var dismiss
    @Dependency(\.nfcClient) var nfcClient
    @Dependency(\.languageRecognizer) var languageRecognizer
    @Dependency(\.speechSynthesizer) var speechSynthesizer

    var body: some ReducerOf<Self> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case .binding(\.text), .binding(\.selectedPayload):
                self.checkEnabledButtons(&state)
                return .run { [state] send in
                    let bytes = await self.countPayloadBytes(state)
                    await send(.updatePayloadBytes(bytes))
                }
            case .updatePayloadBytes(let bytes):
                state.payloadBytes = bytes
                return .none
            case .dismiss:
                return .run { _ in await self.dismiss() }
            case .speakUp:
                return .run { [state] _ in
                    await speechSynthesizer.speak(state.text)
                }
            case .openURL:
                return .run { [text = state.text] _ in
                    if let url = URL(string: text) {
                        await self.openURL(url)
                    }
                }
            case .writeToTag:
                return .run { [state] _ in
                    guard let payloads = await createPayload(state) else {
                        return
                    }
                    try? await nfcClient.write(payloads: [payloads])
                    await self.dismiss()
                }
            case .binding:
                return .none
            }
        }
    }
}

extension WriteTagFeature {
    fileprivate func checkEnabledButtons(_ state: inout State) {
        switch state.selectedPayload {
        case .text:
            state.isButtonsEnabled = !state.text.isEmpty
        case .url:
            state.isButtonsEnabled = URL(string: state.text) != nil
        }
    }

    @MainActor
    fileprivate func countPayloadBytes(_ state: State) -> Int? {
        let payload = self.createPayload(state)?.mapped()
        return payload?.payload.count
    }

    @MainActor
    fileprivate func createPayload(_ state: State) -> NFCNDEFManagerPayload? {
        switch state.selectedPayload {
        case .text:
            let text = state.text

            guard !text.isEmpty else { return nil }

            let locale = languageRecognizer.detectLocale(text)
            return .wellKnown(.text(text, locale))
        case .url:

            guard let url = URL(string: state.text) else {
                return nil
            }

            return .wellKnown(.url(url))
        }
    }
}
