//
//  AppClipNFCLinkService.swift
//  SenseTag
//
//  Created by Ivan Pohorielov on 17.03.2025.
//

import Foundation
import NFCNDEFManager

public struct AppClipNFCLinkService: Hashable, Sendable {

    static func addDefaultLink(_ data: inout [NFCNDEFManagerPayload])
        -> [NFCNDEFManagerPayload]
    {
        data.insert(.wellKnown(.url(URL.appClipDefault)), at: 0)
        return data
    }

    static func removeDefaultLink(_ data: inout [NFCNDEFManagerPayload])
        -> [NFCNDEFManagerPayload]
    {
        data.removeAll { payload in
            if case .wellKnown(.url(let url)) = payload {
                return url == URL.appClipDefault
            }
            return false
        }
        return data
    }
}

extension URL {
    static var appClipDefault: URL {
        return URL(
            string: "https://ivanpohorielov.github.io/tag/" + UUID().uuidString)!
    }
}
