//
//  Image+.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 18.12.2024.
//

import struct SwiftUI.Image

public extension Image {
    init(_ content: ImageContent) {
        switch content {
        case .systemImage(let systemName):
            self.init(systemName: systemName)
        case .image(let name, let bundle):
            self.init(name, bundle: bundle)
        }
    }
    
    init?(_ content: ImageContent?) {
        if let content {
            self.init(content)
        } else {
            return nil
        }
    }
}
