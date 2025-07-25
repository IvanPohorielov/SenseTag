//
//  NFCNDEFClient.swift
//  SenseTag
//
//  Created by Ivan Pohorielov on 06.01.2025.
//

import ComposableArchitecture
@preconcurrency import CoreNFC
import NFCNDEFManager
import SwiftUI

@DependencyClient
public struct NFCNDEFClient: Sendable {
    public var read: @Sendable () async throws -> [NFCNDEFManagerPayload]
    public var write: @Sendable (_ payloads: [NFCNDEFManagerPayload]) async throws -> Void
    public var clear: @Sendable () async throws -> Void
    public var lock: @Sendable () async throws -> Void
    public var parseNDEFMessage: @Sendable (_ message: NFCNDEFMessage) async -> [NFCNDEFManagerPayload] = { _ in [] }
}

extension NFCNDEFClient: DependencyKey {
    public static var liveValue: Self {
        let nfcManager = NFCNDEFManager()
        return Self(
            read: {
                var payloads = try await nfcManager.read()
                return AppClipNFCLinkService.removeDefaultLink(&payloads)
            },
            write: { payloads in
                var payloads = consume payloads
                try await nfcManager.write(
                    AppClipNFCLinkService.addDefaultLink(&payloads)
                )
            },
            clear: { try await nfcManager.clear() },
            lock: { try await nfcManager.lock() },
            parseNDEFMessage: { await nfcManager.parseNDEFMessage($0) }
        )
    }
}

extension DependencyValues {
    public var nfcClient: NFCNDEFClient {
        get { self[NFCNDEFClient.self] }
        set { self[NFCNDEFClient.self] = newValue }
    }
}
