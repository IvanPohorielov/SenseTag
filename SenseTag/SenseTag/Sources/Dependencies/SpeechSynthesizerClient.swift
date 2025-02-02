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
    var speak: @MainActor @Sendable (AVSpeechUtterance) async -> Void
    var stopSpeaking: @MainActor @Sendable (AVSpeechBoundary) async -> Void
    var pauseSpeaking: @MainActor @Sendable (AVSpeechBoundary) async -> Void
    var continueSpeaking: @MainActor @Sendable () async -> Void
    var isSpeaking: @MainActor @Sendable () async -> Bool = { false }
}

private enum SpeechSynthesizerClientKey: DependencyKey {
    static let liveValue: SpeechSynthesizerClient = {
        nonisolated(unsafe) let synthesizer = AVSpeechSynthesizer()

        return SpeechSynthesizerClient(
            speak: { utterance in
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
        get { self[SpeechSynthesizerClientKey.self] }
        set { self[SpeechSynthesizerClientKey.self] = newValue }
    }
}
