//
//  NFCNDEFManagerPayload.swift
//  NFCNDEFManager
//
//  Created by Ivan Pohorielov on 10.12.2024.
//

@preconcurrency import CoreNFC
import Foundation

public enum NFCNDEFManagerPayload: Hashable, Sendable {
    case wellKnown(WellKnownPayload)
    case empty
    case other(NFCNDEFPayload)
}

public extension NFCNDEFManagerPayload {
    enum WellKnownPayload: Hashable, Sendable {
        case text(String, Locale)
        case url(URL)
    }
}
