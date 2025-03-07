//
//  CoreButtonSize.swift
//  PromUI
//
//  Created by Ivan Pohorielov on 24.10.2024.
//

import Foundation
import struct SwiftUI.Font
import class UIKit.UIFont

protocol CoreButtonSize: Hashable, Sendable, CaseIterable {
    var lineLimit: Int? { get }
    var font: Font { get }
    var fontStyle: UIFont.TextStyle { get }
    var iconSize: CGFloat { get }
    var borderWidth: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var contentIdealHeight: CGFloat { get }
    var contentVerticalPadding: CGFloat { get }
    var contentHorizontalPadding: CGFloat { get }
    var mainStackSpacing: CGFloat { get }

    // MARK: - Default sizes

    static var large: Self { get }
    static var regular: Self { get }
    static var compact: Self { get }
}

extension CoreButtonSize {
    public static var allCases: [Self] {
        [
            large,
            regular,
            compact,
        ]
    }
}
