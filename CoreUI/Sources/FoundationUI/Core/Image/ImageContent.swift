//
//  ImageContent.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 18.12.2024.
//

import Foundation

public enum ImageContent: Identifiable, Hashable, Sendable {
    case systemImage(String)
    case image(String, Bundle? = nil)
    
    public var id: String {
        switch self {
        case .systemImage(let name):
            return "systemImage" + name
        case .image(let name, _):
            return "image" + name
        }
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
