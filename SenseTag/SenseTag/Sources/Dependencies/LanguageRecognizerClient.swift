//
//  LanguageRecognizerClient.swift
//  SenseTag
//
//  Created by Ivan Pohorielov on 08.02.2025.
//

import Foundation
import NaturalLanguage
import ComposableArchitecture

@DependencyClient
struct LanguageRecognizerClient {
    var detectLocale: @MainActor @Sendable (String) -> Locale = { _ in Locale(identifier: "en-US") }
}

extension LanguageRecognizerClient: DependencyKey {
    static let liveValue = LanguageRecognizerClient(
        detectLocale: { text in
            if let languageCode = NLLanguageRecognizer.dominantLanguage(for: text)?.rawValue {
                return Locale(identifier: languageCode)
            }
            
            return Locale(identifier: "en-US")
        }
    )
}

extension DependencyValues {
    var languageRecognizer: LanguageRecognizerClient {
        get { self[LanguageRecognizerClient.self] }
        set { self[LanguageRecognizerClient.self] = newValue }
    }
}
