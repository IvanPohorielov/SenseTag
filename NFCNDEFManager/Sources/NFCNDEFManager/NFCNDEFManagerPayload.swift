//
//  NFCNDEFManagerPayload.swift
//  NFCNDEFManager
//
//  Created by Ivan Pohorielov on 10.12.2024.
//

import Foundation


public struct NFCNDEFManagerPayload: Hashable, Sendable {
    
    public let type: NFCNDEFPayloadType
    public let data: Data
    
    public init (text: String) {
        self.type = .text
        self.data = Data(text.utf8)
    }
    
    public init (url: URL) {
        self.type = .url
        self.data = Data(url.absoluteString.utf8)
    }
}

public extension NFCNDEFManagerPayload {
    
    func extractText() throws -> String {
        guard type == .text else {
            throw NFCError.noPayload
        }
        guard let text = String(data: data, encoding: .utf8) else {
            throw NFCError.noPayload
        }
        return text
    }
    
    func extractURL() throws -> URL {
        guard type == .url else {
            throw NFCError.noPayload
        }
        guard let urlString = String(data: data, encoding: .utf8), let url = URL(string: urlString) else {
            throw NFCError.noPayload
        }
        return url
    }
}
