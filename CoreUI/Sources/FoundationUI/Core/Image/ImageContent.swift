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
        case let .systemImage(name):
            return "systemImage" + name
        case let .image(name, _):
            return "image" + name
        }
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
