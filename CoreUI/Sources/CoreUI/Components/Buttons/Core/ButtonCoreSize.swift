//
//  ButtonCoreLayout.swift
//  PromUI
//
//  Created by Ivan Pohorielov on 24.10.2024.
//

import Foundation
import struct SwiftUI.Font

protocol ButtonCoreSize: Hashable, Sendable, CaseIterable {
    
    var lineLimit: Int? { get }
    var font: Font { get }
    var iconSize: CGFloat { get }
    var borderWidth: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var idealContentHeight: CGFloat { get }
    var contentVerticalPadding: CGFloat { get }
    var contentHorizontalPadding: CGFloat { get }
    var mainStackSpacing: CGFloat { get }
    
    // MARK: - Default sizes
    
    static var large: Self { get }
    static var regular: Self { get }
    static var compact: Self { get }
    
}

extension ButtonCoreSize {
    public static var allCases: [Self] {
        [
            Self.large,
            Self.regular,
            Self.compact
        ]
    }
}
