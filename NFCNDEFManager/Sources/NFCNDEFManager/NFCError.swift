//
//  NFCError.swift
//  NFCNDEFManager
//
//  Created by Ivan Pohorielov on 10.12.2024.
//

import Foundation

public enum NFCError: Error, Sendable {
    // Common error
    case nfcNotAvailable
    case sessionAlreadyRunning
    case sessionInvalidated(String)
    
    // Payload
    case noPayload
    
    // Tag status specific
    case notSupportedTagStatus
    case readOnlyTagStatus
    case unknownTagStatus
}
