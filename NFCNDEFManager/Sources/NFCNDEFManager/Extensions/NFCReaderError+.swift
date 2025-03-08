//
//  NFCReaderError+.swift
//  NFCNDEFManager
//
//  Created by Ivan Pohorielov on 08.03.2025.
//

import CoreNFC

public extension NFCReaderError {
    var localizedString: LocalizedStringResource {
        switch self {
        case NFCReaderError.readerErrorUnsupportedFeature:
            return LocalizedStringResource(
                "NFCNDEFManager.NFCReaderError.readerErrorUnsupportedFeature",
                defaultValue: "Core NFC is not supported on this device.",
                bundle: .atURL(Bundle.module.bundleURL),
                comment: "Localized message for NFCReaderError: readerErrorUnsupportedFeature"
            )
        case NFCReaderError.readerErrorSecurityViolation:
            return LocalizedStringResource(
                "NFCNDEFManager.NFCReaderError.readerErrorSecurityViolation",
                defaultValue: "Missing required entitlement or privacy settings.",
                bundle: .atURL(Bundle.module.bundleURL),
                comment: "Localized message for NFCReaderError: readerErrorSecurityViolation"
            )
        case NFCReaderError.readerErrorInvalidParameter:
            return LocalizedStringResource(
                "NFCNDEFManager.NFCReaderError.readerErrorInvalidParameter",
                defaultValue: "Invalid parameter provided.",
                bundle: .atURL(Bundle.module.bundleURL),
                comment: "Localized message for NFCReaderError: readerErrorInvalidParameter"
            )
        case NFCReaderError.readerErrorInvalidParameterLength:
            return LocalizedStringResource(
                "NFCNDEFManager.NFCReaderError.readerErrorInvalidParameterLength",
                defaultValue: "Parameter length is invalid.",
                bundle: .atURL(Bundle.module.bundleURL),
                comment: "Localized message for NFCReaderError: readerErrorInvalidParameterLength"
            )
        case NFCReaderError.readerErrorParameterOutOfBound:
            return LocalizedStringResource(
                "NFCNDEFManager.NFCReaderError.readerErrorParameterOutOfBound",
                defaultValue: "Parameter value is out of bounds.",
                bundle: .atURL(Bundle.module.bundleURL),
                comment: "Localized message for NFCReaderError: readerErrorParameterOutOfBound"
            )
        case NFCReaderError.readerErrorRadioDisabled:
            return LocalizedStringResource(
                "NFCNDEFManager.NFCReaderError.readerErrorRadioDisabled",
                defaultValue: "NFC Radio is disabled.",
                bundle: .atURL(Bundle.module.bundleURL),
                comment: "Localized message for NFCReaderError: readerErrorRadioDisabled"
            )
        case NFCReaderError.readerTransceiveErrorTagConnectionLost:
            return LocalizedStringResource(
                "NFCNDEFManager.NFCReaderError.readerTransceiveErrorTagConnectionLost",
                defaultValue: "Connection to the NFC tag was lost.",
                bundle: .atURL(Bundle.module.bundleURL),
                comment: "Localized message for NFCReaderError: readerTransceiveErrorTagConnectionLost"
            )
        case NFCReaderError.readerTransceiveErrorRetryExceeded:
            return LocalizedStringResource(
                "NFCNDEFManager.NFCReaderError.readerTransceiveErrorRetryExceeded",
                defaultValue: "Maximum transmission retries reached.",
                bundle: .atURL(Bundle.module.bundleURL),
                comment: "Localized message for NFCReaderError: readerTransceiveErrorRetryExceeded"
            )
        case NFCReaderError.readerTransceiveErrorTagResponseError:
            return LocalizedStringResource(
                "NFCNDEFManager.NFCReaderError.readerTransceiveErrorTagResponseError",
                defaultValue: "Invalid tag response or no response.",
                bundle: .atURL(Bundle.module.bundleURL),
                comment: "Localized message for NFCReaderError: readerTransceiveErrorTagResponseError"
            )
        case NFCReaderError.readerTransceiveErrorSessionInvalidated:
            return LocalizedStringResource(
                "NFCNDEFManager.NFCReaderError.readerTransceiveErrorSessionInvalidated",
                defaultValue: "Session has been invalidated.",
                bundle: .atURL(Bundle.module.bundleURL),
                comment: "Localized message for NFCReaderError: readerTransceiveErrorSessionInvalidated"
            )
        case NFCReaderError.readerTransceiveErrorTagNotConnected:
            return LocalizedStringResource(
                "NFCNDEFManager.NFCReaderError.readerTransceiveErrorTagNotConnected",
                defaultValue: "Tag is not connected.",
                bundle: .atURL(Bundle.module.bundleURL),
                comment: "Localized message for NFCReaderError: readerTransceiveErrorTagNotConnected"
            )
        case NFCReaderError.readerTransceiveErrorPacketTooLong:
            return LocalizedStringResource(
                "NFCNDEFManager.NFCReaderError.readerTransceiveErrorPacketTooLong",
                defaultValue: "Packet length exceeds the limit.",
                bundle: .atURL(Bundle.module.bundleURL),
                comment: "Localized message for NFCReaderError: readerTransceiveErrorPacketTooLong"
            )
        case NFCReaderError.readerSessionInvalidationErrorUserCanceled:
            return LocalizedStringResource(
                "NFCNDEFManager.NFCReaderError.readerSessionInvalidationErrorUserCanceled",
                defaultValue: "Session was canceled by the user.",
                bundle: .atURL(Bundle.module.bundleURL),
                comment: "Localized message for NFCReaderError: readerSessionInvalidationErrorUserCanceled"
            )
        case NFCReaderError.readerSessionInvalidationErrorSessionTimeout:
            return LocalizedStringResource(
                "NFCNDEFManager.NFCReaderError.readerSessionInvalidationErrorSessionTimeout",
                defaultValue: "NFC session timed out.",
                bundle: .atURL(Bundle.module.bundleURL),
                comment: "Localized message for NFCReaderError: readerSessionInvalidationErrorSessionTimeout"
            )
        case NFCReaderError.readerSessionInvalidationErrorSessionTerminatedUnexpectedly:
            return LocalizedStringResource(
                "NFCNDEFManager.NFCReaderError.readerSessionInvalidationErrorSessionTerminatedUnexpectedly",
                defaultValue: "Session terminated unexpectedly.",
                bundle: .atURL(Bundle.module.bundleURL),
                comment: "Localized message for NFCReaderError: readerSessionInvalidationErrorSessionTerminatedUnexpectedly"
            )
        case NFCReaderError.readerSessionInvalidationErrorSystemIsBusy:
            return LocalizedStringResource(
                "NFCNDEFManager.NFCReaderError.readerSessionInvalidationErrorSystemIsBusy",
                defaultValue: "Core NFC is temporarily unavailable.",
                bundle: .atURL(Bundle.module.bundleURL),
                comment: "Localized message for NFCReaderError: readerSessionInvalidationErrorSystemIsBusy"
            )
        case NFCReaderError.readerSessionInvalidationErrorFirstNDEFTagRead:
            return LocalizedStringResource(
                "NFCNDEFManager.NFCReaderError.readerSessionInvalidationErrorFirstNDEFTagRead",
                defaultValue: "Session ended after reading the first NDEF tag.",
                bundle: .atURL(Bundle.module.bundleURL),
                comment: "Localized message for NFCReaderError: readerSessionInvalidationErrorFirstNDEFTagRead"
            )
        case NFCReaderError.tagCommandConfigurationErrorInvalidParameters:
            return LocalizedStringResource(
                "NFCNDEFManager.NFCReaderError.tagCommandConfigurationErrorInvalidParameters",
                defaultValue: "Invalid tag command configuration parameters.",
                bundle: .atURL(Bundle.module.bundleURL),
                comment: "Localized message for NFCReaderError: tagCommandConfigurationErrorInvalidParameters"
            )
        case NFCReaderError.ndefReaderSessionErrorTagNotWritable:
            return LocalizedStringResource(
                "NFCNDEFManager.NFCReaderError.ndefReaderSessionErrorTagNotWritable",
                defaultValue: "The NDEF tag is not writable.",
                bundle: .atURL(Bundle.module.bundleURL),
                comment: "Localized message for NFCReaderError: ndefReaderSessionErrorTagNotWritable"
            )
        case NFCReaderError.ndefReaderSessionErrorTagUpdateFailure:
            return LocalizedStringResource(
                "NFCNDEFManager.NFCReaderError.ndefReaderSessionErrorTagUpdateFailure",
                defaultValue: "Failed to update the NDEF tag.",
                bundle: .atURL(Bundle.module.bundleURL),
                comment: "Localized message for NFCReaderError: ndefReaderSessionErrorTagUpdateFailure"
            )
        case NFCReaderError.ndefReaderSessionErrorTagSizeTooSmall:
            return LocalizedStringResource(
                "NFCNDEFManager.NFCReaderError.ndefReaderSessionErrorTagSizeTooSmall",
                defaultValue: "The NDEF tag size is too small.",
                bundle: .atURL(Bundle.module.bundleURL),
                comment: "Localized message for NFCReaderError: ndefReaderSessionErrorTagSizeTooSmall"
            )
        case NFCReaderError.ndefReaderSessionErrorZeroLengthMessage:
            return LocalizedStringResource(
                "NFCNDEFManager.NFCReaderError.ndefReaderSessionErrorZeroLengthMessage",
                defaultValue: "The NDEF tag contains no data.",
                bundle: .atURL(Bundle.module.bundleURL),
                comment: "Localized message for NFCReaderError: ndefReaderSessionErrorZeroLengthMessage"
            )
        default:
            return LocalizedStringResource(
                "NFCNDEFManager.NFCReaderError.readerErrorUnsupportedFeature",
                defaultValue: "Core NFC is not supported on this device.",
                bundle: .atURL(Bundle.module.bundleURL),
                comment: "Localized message for NFCReaderError: readerErrorUnsupportedFeature"
            )
        }
    }
}
