//
//  PasteboardClient.swift
//  SenseTag
//
//  Created by Ivan Pohorielov on 08.01.2025.
//

import UIKit
import ComposableArchitecture

@DependencyClient
struct PasteboardClient {
    var getString: @MainActor @Sendable () async -> String?
    var setString: @MainActor @Sendable (String) async -> Void
}

private enum PasteboardClientKey: DependencyKey {
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
        get { self[PasteboardClientKey.self] }
        set { self[PasteboardClientKey.self] = newValue }
    }
}
