//
//  CoreButtonContent.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 20.12.2024.
//

import FoundationUI

public struct CoreButtonContent: Hashable, Sendable {
    public var text: String
    public var icon: ImageContent?

    public init(
        text: String,
        icon: ImageContent? = nil
    ) {
        self.text = text
        self.icon = icon
    }
}
