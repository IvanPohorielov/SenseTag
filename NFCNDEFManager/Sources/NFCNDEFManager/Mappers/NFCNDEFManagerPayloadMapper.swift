//
//  NFCNDEFManagerPayloadMapper.swift
//  NFCNDEFManager
//
//  Created by Ivan Pohorielov on 10.12.2024.
//

@preconcurrency import CoreNFC

extension NFCNDEFManagerPayload {
    func mapped() -> NFCNDEFPayload {
        switch self {
        case let .wellKnown(wellKnownPayload):
            switch wellKnownPayload {
            case let .text(text, locale):
                return NFCNDEFPayload.wellKnownTypeTextPayload(string: text, locale: locale) ?? NFCNDEFPayload.empty()
            case let .url(url):
                return NFCNDEFPayload.wellKnownTypeURIPayload(url: url) ?? NFCNDEFPayload.empty()
            }
        case .empty:
            return NFCNDEFPayload.empty()
        case let .other(payload):
            return payload
        }
    }
}
