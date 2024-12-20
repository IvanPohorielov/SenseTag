//
//  ButtonCoreBorderShape.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 18.12.2024.
//

import SwiftUI
import FoundationUI

public enum ButtonCoreBorderShape: String, Hashable, Sendable, CaseIterable {
    case roundedRectangle
    case capsule
}

extension ButtonCoreBorderShape {
    func shape(coreRadius: CGFloat) -> AnyShape {
        switch self {
        case .roundedRectangle:
            return AnyShape(RoundedRectangle(cornerRadius: coreRadius))
        case .capsule:
            return AnyShape(Capsule())
        }
    }
}
