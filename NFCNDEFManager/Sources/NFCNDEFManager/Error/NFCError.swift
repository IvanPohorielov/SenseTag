//
//  NFCError.swift
//  NFCNDEFManager
//
//  Created by Ivan Pohorielov on 10.12.2024.
//

import Foundation

public enum NFCError: Error, Sendable {
    // Common error
    case readerNFCUnsupported
    
    // Session
    case sessionAlreadyRunning
    case sessionInvalidated(String)
    
    // Tag status specific
    case tagNotSupportedStatus
    case tagReadOnlyStatus
    case tagUnknownStatus
}
