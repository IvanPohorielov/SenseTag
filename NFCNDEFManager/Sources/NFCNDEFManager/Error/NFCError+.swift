//
//  NFCError+.swift
//  NFCNDEFManager
//
//  Created by Ivan Pohorielov on 09.03.2025.
//

import Foundation

public extension NFCError {
    var localizedString: LocalizedStringResource {
        switch self {
        case .readerNFCUnsupported:
            return LocalizedStringResource(
                "NFCNDEFManager.NFCError.readerNFCUnsupported",
                defaultValue: "NFC is not supported on this device.",
                bundle: .atURL(Bundle.module.bundleURL),
                comment: "Localized message for NFCError.readerNFCUnsupported"
            )
        case .sessionAlreadyRunning:
            return LocalizedStringResource(
                "NFCNDEFManager.NFCError.sessionAlreadyRunning",
                defaultValue: "NFC session is already running.",
                bundle: .atURL(Bundle.module.bundleURL),
                comment: "Localized message for NFCError.sessionAlreadyRunning"
            )
        case .tagNotSupportedStatus:
            return LocalizedStringResource(
                "NFCNDEFManager.NFCError.tagNotSupportedStatus",
                defaultValue: "NFC tag is not supported.",
                bundle: .atURL(Bundle.module.bundleURL),
                comment: "Localized message for NFCError.tagNotSupportedStatus"
            )
        case .tagReadOnlyStatus:
            return LocalizedStringResource(
                "NFCNDEFManager.NFCError.tagReadOnlyStatus",
                defaultValue: "NFC tag is read-only.",
                bundle: .atURL(Bundle.module.bundleURL),
                comment: "Localized message for NFCError.tagReadOnlyStatus"
            )
        case .tagUnknownStatus:
            return LocalizedStringResource(
                "NFCNDEFManager.NFCError.tagUnknownStatus",
                defaultValue: "Unknown NFC tag status.",
                bundle: .atURL(Bundle.module.bundleURL),
                comment: "Localized message for NFCError.tagUnknownStatus"
            )
        }
    }
}
