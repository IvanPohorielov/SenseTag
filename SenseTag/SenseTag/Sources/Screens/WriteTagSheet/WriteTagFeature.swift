//
//  WriteTag.swift
//  SenseTag
//
//  Created by Ivan Pohorielov on 05.02.2025.
//

import ComposableArchitecture
import Foundation
import NFCNDEFManager
import CoreNFC

@Reducer
struct WriteTagFeature {
    @ObservableState
    struct State: Equatable {
        var selectedPayload: NFCNDEFWellKnownPayloadType = .text
        var text: String = ""
        var payloadBytes: Int? = nil
        var isButtonsEnabled: Bool = false
        var screenState: ScreenState = .content
    }

    enum Action: BindableAction {
        case dismiss
        case binding(BindingAction<State>)
        case writeToTag
        case speakUp
        case openURL
        case updatePayloadBytes(Int?)
        case updateButtonsEnabled(Bool)
        case updateScreenState(ScreenState)
    }

    @Dependency(\.openURL) var openURL
    @Dependency(\.dismiss) var dismiss
    @Dependency(\.application) var application
    @Dependency(\.nfcClient) var nfcClient
    @Dependency(\.languageRecognizer) var languageRecognizer
    @Dependency(\.speechSynthesizer) var speechSynthesizer

    var body: some ReducerOf<Self> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case .binding(\.text), .binding(\.selectedPayload):
                return .run { [state] send in
                    async let _bytes = self.countPayloadBytes(state)
                    async let _enabled = self.checkEnabledButtons(state)
                    let (bytes, enabled) = await (_bytes, _enabled)
                    await send(.updatePayloadBytes(bytes))
                    await send(.updateButtonsEnabled(enabled))
                }
            case .updatePayloadBytes(let bytes):
                state.payloadBytes = bytes
                return .none
            case .updateButtonsEnabled(let enabled):
                state.isButtonsEnabled = enabled
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
                return .run { [state] send in
                    guard let payloads = await createPayload(state) else {
                        return
                    }
                    await send(.updateScreenState(.loading), animation: .default)
                    do {
                        try await nfcClient.write(payloads: [payloads])
                        await self.dismiss()
                    } catch {
                        switch error {
                        case let nfcError as NFCError :
                            await send(.updateScreenState(.error(String(localized: nfcError.localizedString))), animation: .default)
                        case let nfcReaderError as NFCReaderError:
                            await send(.updateScreenState(.error(String(localized: nfcReaderError.localizedString))), animation: .default)
                        default:
                            await send(.updateScreenState(.error(error.localizedDescription)), animation: .default)
                        }
                    }
                }
            case .updateScreenState(let screenState):
                state.screenState = screenState
                return .none
            case .binding:
                return .none
            }
        }
    }
}

extension WriteTagFeature {
    fileprivate func checkEnabledButtons(_ state: State) async -> Bool {
        switch state.selectedPayload {
        case .text:
            return !state.text.isEmpty
        case .url:
            guard let url = URL(string: state.text) else { return false }
            return await application.canOpenURL(url)
        }
    }

    fileprivate func countPayloadBytes(_ state: State) async -> Int? {
        let payload = await self.createPayload(state)?.mapped()
        return payload?.payload.count
    }
    
    fileprivate func createPayload(_ state: State) async -> NFCNDEFManagerPayload? {
        switch state.selectedPayload {
        case .text:
            let text = state.text

            guard !text.isEmpty else { return nil }

            let locale = await languageRecognizer.detectLocale(text)
            return .wellKnown(.text(text, locale))
        case .url:

            guard let url = URL(string: state.text) else {
                return nil
            }
            return .wellKnown(.url(url))
        }
    }
}

extension WriteTagFeature {
    enum ScreenState: Hashable, Sendable {
        case content
        case loading
        case error(String)
    }
}
