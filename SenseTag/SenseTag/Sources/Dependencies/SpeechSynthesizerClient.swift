//
//  SpeechSynthesizerClient.swift
//  SenseTag
//
//  Created by Ivan Pohorielov on 08.01.2025.
//

@preconcurrency import AVFoundation
import ComposableArchitecture

@DependencyClient
struct SpeechSynthesizerClient {
    var speak: @MainActor @Sendable (String) async -> Void
    var stopSpeaking: @MainActor @Sendable (AVSpeechBoundary) async -> Void
    var pauseSpeaking: @MainActor @Sendable (AVSpeechBoundary) async -> Void
    var continueSpeaking: @MainActor @Sendable () async -> Void
    var isSpeaking: @MainActor @Sendable () async -> Bool = { false }
}

extension SpeechSynthesizerClient: DependencyKey {
    static let liveValue: SpeechSynthesizerClient = {
        nonisolated(unsafe) let synthesizer = AVSpeechSynthesizer()
        @Dependency(\.languageRecognizer) var languageRecognizer

        return SpeechSynthesizerClient(
            speak: { text in
                let locale = languageRecognizer.detectLocale(text) ?? Locale(identifier: "en-US")
                let utterance = AVSpeechUtterance(string: text)
                utterance.prefersAssistiveTechnologySettings = true
                utterance.voice = AVSpeechSynthesisVoice(identifier: locale.identifier)
                
                synthesizer.speak(utterance)
            },
            stopSpeaking: { boundary in
                synthesizer.stopSpeaking(at: boundary)
            },
            pauseSpeaking: { boundary in
                synthesizer.pauseSpeaking(at: boundary)
            },
            continueSpeaking: {
                synthesizer.continueSpeaking()
            },
            isSpeaking: {
                synthesizer.isSpeaking
            }
        )
    }()
}

extension DependencyValues {
    var speechSynthesizer: SpeechSynthesizerClient {
        get { self[SpeechSynthesizerClient.self] }
        set { self[SpeechSynthesizerClient.self] = newValue }
    }
}
