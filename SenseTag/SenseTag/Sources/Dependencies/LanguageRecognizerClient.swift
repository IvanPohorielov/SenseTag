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
    
    var detectLocale: @MainActor @Sendable (String) -> Locale?
}

extension LanguageRecognizerClient: DependencyKey {
    static let liveValue = LanguageRecognizerClient(
        detectLocale: { text in
            let recognizer = NLLanguageRecognizer()
            recognizer.processString(text)
            
            if let languageCode = recognizer.dominantLanguage?.rawValue {
                return Locale(identifier: languageCode)
            }
            
            return nil
        }
    )
}

extension DependencyValues {
    var languageRecognizer: LanguageRecognizerClient {
        get { self[LanguageRecognizerClient.self] }
        set { self[LanguageRecognizerClient.self] = newValue }
    }
}
