//
//  Color+.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 15.12.2024.
//

import struct SwiftUI.Color

// MARK: - SwiftUI Proxy

public struct DefaultPaletteSwiftUIProxy: Hashable, Sendable, Palette {
    private let palette: DefaultPalette

    init(_ palette: DefaultPalette) {
        self.palette = palette
    }

    public var primary: Color { palette.primary.color }
    public var shade50: Color { palette.shade50.color }
    public var shade100: Color { palette.shade100.color }
    public var shade200: Color { palette.shade200.color }
    public var shade300: Color { palette.shade300.color }
    public var shade400: Color { palette.shade400.color }
    public var shade500: Color { palette.shade500.color }
    public var shade600: Color { palette.shade600.color }
    public var shade700: Color { palette.shade700.color }
    public var shade800: Color { palette.shade800.color }
    public var shade900: Color { palette.shade900.color }
}

// MARK: - Color extension

public extension Color {
    static let black: DefaultPaletteSwiftUIProxy = DefaultColors.black.swiftUI
    static let violet: DefaultPaletteSwiftUIProxy = DefaultColors.violet.swiftUI
    static let green: DefaultPaletteSwiftUIProxy = DefaultColors.green.swiftUI
    static let yellow: DefaultPaletteSwiftUIProxy = DefaultColors.yellow.swiftUI
    static let orange: DefaultPaletteSwiftUIProxy = DefaultColors.orange.swiftUI
    static let red: DefaultPaletteSwiftUIProxy = DefaultColors.red.swiftUI
    static let blue: DefaultPaletteSwiftUIProxy = DefaultColors.blue.swiftUI
    static let absoluteWhite: Color = DefaultColors.white.color
}
