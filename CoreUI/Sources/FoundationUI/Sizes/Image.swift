//
//  Image.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 15.12.2024.
//

import Foundation
import SwiftUI

public struct DefaultImage: Sendable {
    static public let image40: CGFloat = 40
    static public let image56: CGFloat = 56
    static public let image120: CGFloat = 120
    static public let image160: CGFloat = 160
}

public extension CGFloat {
    static let image40: CGFloat = DefaultImage.image40
    static let image56: CGFloat = DefaultImage.image56
    static let image120: CGFloat = DefaultImage.image120
    static let image160: CGFloat = DefaultImage.image160
}

public extension View {
    
    func frameImage40() -> some View {
        frame(
            width: .image40,
            height: .image40
        )
    }
    
    func frameImage56() -> some View {
        frame(
            width: .image56,
            height: .image56
        )
    }
    
    func frameImage120() -> some View {
        frame(
            width: .image120,
            height: .image120
        )
    }
    
    func frameImage160() -> some View {
        frame(
            width: .image160,
            height: .image160
        )
    }
}
