//
//  CoreInputContent.swift
//
//
//  Created by Ivan Pohorielov on 02.05.2024.
//

import SwiftUI

public struct CoreInputContent: CoreInputContainerContentProtocol {
    @Binding
    public var text: String

    public let placeholder: String
    public let label: String?
    public let caption: String?
    public var error: String?

    public init(
        text: Binding<String>,
        placeholder: String? = nil,
        label: String? = nil,
        caption: String? = nil,
        error: String? = nil
    ) {
        _text = text
        self.placeholder = placeholder ?? ""
        self.label = label
        self.caption = caption
        self.error = error
    }
}
