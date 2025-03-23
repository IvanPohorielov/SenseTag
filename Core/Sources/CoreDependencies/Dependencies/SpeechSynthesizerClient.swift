//
//  SpeechSynthesizerClient.swift
//  SenseTag
//
//  Created by Ivan Pohorielov on 08.01.2025.
//

@preconcurrency import AVFoundation
import ComposableArchitecture

@DependencyClient
public struct SpeechSynthesizerClient: Sendable {
    public var speak: @MainActor @Sendable (String) async -> Void
    public var stopSpeaking: @MainActor @Sendable (AVSpeechBoundary) async -> Void
    public var pauseSpeaking: @MainActor @Sendable (AVSpeechBoundary) async -> Void
    public var continueSpeaking: @MainActor @Sendable () async -> Void
    public var isSpeaking: @MainActor @Sendable () async -> Bool = { false }
}

extension SpeechSynthesizerClient: DependencyKey {
    public static let liveValue: SpeechSynthesizerClient = {
        nonisolated(unsafe) let synthesizer = AVSpeechSynthesizer()
        @Dependency(\.languageRecognizer) var languageRecognizer

        return SpeechSynthesizerClient(
            speak: { text in
                let locale =
                    languageRecognizer.detectLocale(text)

                let utterance = AVSpeechUtterance(string: text)

                // If text locale and current voice locale is the same use prefered
                let ovverrideVoice =
                    AVSpeechSynthesisVoice.currentLanguageCode()
                    == locale.language.languageCode?.identifier

                utterance.prefersAssistiveTechnologySettings = ovverrideVoice
                utterance.voice = bestVoice(for: locale)

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

extension SpeechSynthesizerClient {
    fileprivate static func bestVoice(for locale: Locale)
        -> AVSpeechSynthesisVoice?
    {

        guard let languageCode = locale.language.languageCode?.identifier else {
            return nil
        }

        let availableVoices = AVSpeechSynthesisVoice.speechVoices()

        // First, try to get a premium quality voice for the specified locale
        if let premiumVoice = availableVoices.first(where: {
            $0.language.contains(languageCode) && $0.quality == .premium
        }) {
            return premiumVoice
        }

        // If no premium Voice, try to get a enhanced voice
        if let enhancedVoice = availableVoices.first(where: {
            $0.language.contains(languageCode) && $0.quality == .enhanced
        }) {
            return enhancedVoice
        }

        // If no enhanced voice, try to get a regular voice
        if let regularVoice = availableVoices.first(where: {
            $0.language.contains(languageCode)
        }) {
            return regularVoice
        }

        // Default to a fallback voice if no match found
        return AVSpeechSynthesisVoice(identifier: locale.identifier)
    }
}

public extension DependencyValues {
    var speechSynthesizer: SpeechSynthesizerClient {
        get { self[SpeechSynthesizerClient.self] }
        set { self[SpeechSynthesizerClient.self] = newValue }
    }
}
