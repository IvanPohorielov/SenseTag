//
//  UIColor+.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 15.12.2024.
//

import class UIKit.UIColor

// MARK: - UIKit Proxy

public struct DefaultPaletteUIKitProxy: Hashable, Sendable, Palette {
    private let palette: DefaultPalette

    init(_ palette: DefaultPalette) {
        self.palette = palette
    }

    public var primary: UIColor { palette.primary.uiColor }
    public var shade50: UIColor { palette.shade50.uiColor }
    public var shade100: UIColor { palette.shade100.uiColor }
    public var shade200: UIColor { palette.shade200.uiColor }
    public var shade300: UIColor { palette.shade300.uiColor }
    public var shade400: UIColor { palette.shade400.uiColor }
    public var shade500: UIColor { palette.shade500.uiColor }
    public var shade600: UIColor { palette.shade600.uiColor }
    public var shade700: UIColor { palette.shade700.uiColor }
    public var shade800: UIColor { palette.shade800.uiColor }
    public var shade900: UIColor { palette.shade900.uiColor }
}

// MARK: - UIColor extension

public extension UIColor {
    static let black: DefaultPaletteUIKitProxy = DefaultColors.black.uiKit
    static let violet: DefaultPaletteUIKitProxy = DefaultColors.violet.uiKit
    static let green: DefaultPaletteUIKitProxy = DefaultColors.green.uiKit
    static let yellow: DefaultPaletteUIKitProxy = DefaultColors.yellow.uiKit
    static let orange: DefaultPaletteUIKitProxy = DefaultColors.orange.uiKit
    static let red: DefaultPaletteUIKitProxy = DefaultColors.red.uiKit
    static let blue: DefaultPaletteUIKitProxy = DefaultColors.blue.uiKit
    static let absoluteWhite: UIColor = DefaultColors.white.uiColor
}
