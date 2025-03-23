//
//  LanguageRecognizerClient.swift
//  SenseTag
//
//  Created by Ivan Pohorielov on 08.02.2025.
//

import ComposableArchitecture
import Foundation
import NaturalLanguage

@DependencyClient
public struct LanguageRecognizerClient: Sendable {
    public var detectLocale: @MainActor @Sendable (String) -> Locale = { _ in
        Locale(identifier: "en-US")
    }
}

extension LanguageRecognizerClient: DependencyKey {
    public static let liveValue = LanguageRecognizerClient(
        detectLocale: { text in
            if let languageCode = NLLanguageRecognizer.dominantLanguage(
                for: text)?.rawValue
            {
                return Locale(identifier: languageCode)
            }

            return Locale(identifier: "en-US")
        }
    )
}

extension DependencyValues {
    public var languageRecognizer: LanguageRecognizerClient {
        get { self[LanguageRecognizerClient.self] }
        set { self[LanguageRecognizerClient.self] = newValue }
    }
}
