//
//  NFCNDEFPayloadType.swift
//  NFCNDEFManager
//
//  Created by Ivan Pohorielov on 10.12.2024.
//

import Foundation

public enum NFCNDEFPayloadType: String, Hashable, CaseIterable, Sendable {
    case text = "T"
    case url = "U"
    
    public var title: String {
        switch self {
        case .text:
            "Text"
        case .url:
            "URL"
        }
    }
    
    var typeNDEF: Data {
        Data(self.rawValue.utf8)
    }
}
