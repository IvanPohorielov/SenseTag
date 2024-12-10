//
//  NFCNDEFManagerPayloadMapper.swift
//  NFCNDEFManager
//
//  Created by Ivan Pohorielov on 10.12.2024.
//

@preconcurrency import CoreNFC

extension NFCNDEFManagerPayload  {
    func mapped() -> NFCNDEFPayload {
        switch self {
        case .wellKnown(let wellKnownPayload):
            switch wellKnownPayload {
            case .text(let text, let locale):
                return NFCNDEFPayload.wellKnownTypeTextPayload(string: text, locale: locale) ?? NFCNDEFPayload.empty()
            case .url(let url):
                return NFCNDEFPayload.wellKnownTypeURIPayload(url: url) ?? NFCNDEFPayload.empty()
            }
        case .empty:
            return NFCNDEFPayload.empty()
        case .other(let payload):
            return payload
        }
    }
}
