//
//  NFCNDEFPayload+.swift
//  NFCNDEFManager
//
//  Created by Ivan Pohorielov on 10.12.2024.
//

import CoreNFC

public extension NFCNDEFPayload {
    
    static func empty() -> NFCNDEFPayload {
        return NFCNDEFPayload(
            format: .empty,
            type: Data(),
            identifier: Data(),
            payload: Data()
        )
    }
}
