//
//  NFCNDEFPayloadType.swift
//  NFCNDEFManager
//
//  Created by Ivan Pohorielov on 10.12.2024.
//

import Foundation

public enum NFCNDEFWellKnownPayloadType: String, Identifiable, Hashable, CaseIterable, Sendable {
    case text = "T"
    case url = "U"

    public var title: LocalizedStringResource {
        switch self {
        case .text:
            LocalizedStringResource(
                "NFCNDEFManager.NFCNDEFWellKnownPayloadType.text",
                defaultValue: "Text",
                bundle: .atURL(Bundle.module.bundleURL),
                comment: "Localized message for NFCNDEFWellKnownPayloadType.text"
            )
        case .url:
            LocalizedStringResource(
                "NFCNDEFManager.NFCNDEFWellKnownPayloadType.url",
                defaultValue: "URL",
                bundle: .atURL(Bundle.module.bundleURL),
                comment: "Localized message for NFCNDEFWellKnownPayloadType.url"
            )
        }
    }
    
    public var id: Self { self }
}
