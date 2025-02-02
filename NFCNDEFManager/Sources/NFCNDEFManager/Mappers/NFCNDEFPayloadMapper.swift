//
//  NFCNDEFPayloadMapper.swift
//  NFCNDEFManager
//
//  Created by Ivan Pohorielov on 10.12.2024.
//

@preconcurrency import CoreNFC

public extension NFCNDEFPayload {
    func mapped() -> NFCNDEFManagerPayload {
        switch typeNameFormat {
        case .nfcWellKnown:

            let wellKnownPayloadType = NFCNDEFWellKnownPayloadType(
                rawValue: String(
                    decoding: type,
                    as: UTF8.self
                )
            )

            switch wellKnownPayloadType {
            case .text:

                let (text, locale) = wellKnownTypeTextPayload()

                guard let text, let locale else {
                    return .other(self)
                }

                return .wellKnown(.text(text, locale))
            case .url:
                guard let url = wellKnownTypeURIPayload() else {
                    return .other(self)
                }

                return .wellKnown(.url(url))
            default:
                return .other(self)
            }
        case .empty:
            return .empty
        default:
            return .other(self)
        }
    }
}
