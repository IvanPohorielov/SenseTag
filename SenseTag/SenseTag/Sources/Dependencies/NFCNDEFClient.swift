//
//  NFCNDEFClient.swift
//  SenseTag
//
//  Created by Ivan Pohorielov on 06.01.2025.
//

import ComposableArchitecture
import NFCNDEFManager
import SwiftUI

@DependencyClient
struct NFCNDEFClient {
    var read: @Sendable () async throws -> [NFCNDEFManagerPayload]
    var write: @Sendable (_ payloads: [NFCNDEFManagerPayload]) async throws -> Void
    var clear: @Sendable () async throws -> Void
    var lock: @Sendable () async throws -> Void
}

extension NFCNDEFClient: DependencyKey {
    static var liveValue: Self {
        let nfcManager = NFCNDEFManager()
        return Self(
            read: {
                var payloads = try await nfcManager.read()
                return AppClipNFCLinkService.removeDefaultLink(&payloads)
            },
            write: { payloads in
                var payloads = consume payloads
                try await nfcManager.write(AppClipNFCLinkService.addDefaultLink(&payloads))
            },
            clear: { try await nfcManager.clear() },
            lock: { try await nfcManager.lock() }
        )
    }
}

extension DependencyValues {
    var nfcClient: NFCNDEFClient {
        get { self[NFCNDEFClient.self] }
        set { self[NFCNDEFClient.self] = newValue }
    }
}
