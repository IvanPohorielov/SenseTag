//
//  PasteboardClient.swift
//  SenseTag
//
//  Created by Ivan Pohorielov on 08.01.2025.
//

import ComposableArchitecture
import UIKit

@DependencyClient
struct PasteboardClient {
    var getString: @MainActor @Sendable () async -> String?
    var setString: @MainActor @Sendable (String) async -> Void
}

extension PasteboardClient: DependencyKey {
    static let liveValue = PasteboardClient(
        getString: {
            UIPasteboard.general.string
        },
        setString: { text in
            UIPasteboard.general.string = text
        }
    )
}

extension DependencyValues {
    var pasteboard: PasteboardClient {
        get { self[PasteboardClient.self] }
        set { self[PasteboardClient.self] = newValue }
    }
}
