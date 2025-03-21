//
//  ReadTagFeature.swift
//  SenseTag
//
//  Created by Ivan Pohorielov on 08.01.2025.
//

import AVFoundation
import ComposableArchitecture
import Foundation
import NFCNDEFManager
import enum SwiftUI.AccessibilityNotification

@Reducer
struct ReadTagFeature {
    @ObservableState
    struct State: Equatable {
        var payloads: [NFCNDEFManagerPayload]
    }

    enum Action {
        case dismiss
        case copyToClipboard(String)
    }
    
    @Dependency(\.dismiss) var dismiss
    @Dependency(\.pasteboard) var pasteboard

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .dismiss:
                return .run { _ in await self.dismiss() }
            case let .copyToClipboard(text):
                return .run { _ in await self.pasteboard.setString(text) }
            }
        }
    }
}
