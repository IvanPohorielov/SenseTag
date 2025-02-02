//
//  Color.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 15.12.2024.
//

import Foundation
import SwiftUI
import class UIKit.UIColor
import class UIKit.UITraitCollection

public struct DefaultColors: Hashable, Sendable {
    public static let black: DefaultPalette = .init(
        primary: \.shade900,
        shade50: DefaultColor("black50"),
        shade100: DefaultColor("black100"),
        shade200: DefaultColor("black200"),
        shade300: DefaultColor("black300"),
        shade400: DefaultColor("black400"),
        shade500: DefaultColor("black500"),
        shade600: DefaultColor("black600"),
        shade700: DefaultColor("black700"),
        shade800: DefaultColor("black800"),
        shade900: DefaultColor("black900")
    )
    public static let violet: DefaultPalette = .init(
        primary: \.shade500,
        shade50: DefaultColor("violet50"),
        shade100: DefaultColor("violet100"),
        shade200: DefaultColor("violet200"),
        shade300: DefaultColor("violet300"),
        shade400: DefaultColor("violet400"),
        shade500: DefaultColor("violet500"),
        shade600: DefaultColor("violet600"),
        shade700: DefaultColor("violet700"),
        shade800: DefaultColor("violet800"),
        shade900: DefaultColor("violet900")
    )
    public static let green: DefaultPalette = .init(
        primary: \.shade700,
        shade50: DefaultColor("green50"),
        shade100: DefaultColor("green100"),
        shade200: DefaultColor("green200"),
        shade300: DefaultColor("green300"),
        shade400: DefaultColor("green400"),
        shade500: DefaultColor("green500"),
        shade600: DefaultColor("green600"),
        shade700: DefaultColor("green700"),
        shade800: DefaultColor("green800"),
        shade900: DefaultColor("green900")
    )
    public static let yellow: DefaultPalette = .init(
        primary: \.shade500,
        shade50: DefaultColor("yellow50"),
        shade100: DefaultColor("yellow100"),
        shade200: DefaultColor("yellow200"),
        shade300: DefaultColor("yellow300"),
        shade400: DefaultColor("yellow400"),
        shade500: DefaultColor("yellow500"),
        shade600: DefaultColor("yellow600"),
        shade700: DefaultColor("yellow700"),
        shade800: DefaultColor("yellow800"),
        shade900: DefaultColor("yellow900")
    )
    public static let orange: DefaultPalette = .init(
        primary: \.shade900,
        shade50: DefaultColor("orange50"),
        shade100: DefaultColor("orange100"),
        shade200: DefaultColor("orange200"),
        shade300: DefaultColor("orange300"),
        shade400: DefaultColor("orange400"),
        shade500: DefaultColor("orange500"),
        shade600: DefaultColor("orange600"),
        shade700: DefaultColor("orange700"),
        shade800: DefaultColor("orange800"),
        shade900: DefaultColor("orange900")
    )
    public static let red: DefaultPalette = .init(
        primary: \.shade900,
        shade50: DefaultColor("red50"),
        shade100: DefaultColor("red100"),
        shade200: DefaultColor("red200"),
        shade300: DefaultColor("red300"),
        shade400: DefaultColor("red400"),
        shade500: DefaultColor("red500"),
        shade600: DefaultColor("red600"),
        shade700: DefaultColor("red700"),
        shade800: DefaultColor("red800"),
        shade900: DefaultColor("red900")
    )
    public static let blue: DefaultPalette = .init(
        primary: \.shade500,
        shade50: DefaultColor("blue50"),
        shade100: DefaultColor("blue100"),
        shade200: DefaultColor("blue200"),
        shade300: DefaultColor("blue300"),
        shade400: DefaultColor("blue400"),
        shade500: DefaultColor("blue500"),
        shade600: DefaultColor("blue600"),
        shade700: DefaultColor("blue700"),
        shade800: DefaultColor("blue800"),
        shade900: DefaultColor("blue900")
    )

    public static let white: DefaultColor = .init("absoluteWhite")

    public static var allPalettas: [DefaultPalette] {
        [
            black,
            violet,
            green,
            yellow,
            orange,
            red,
            blue,
        ]
    }

    public static var allColors: [DefaultColor] {
        [white]
            +
            allPalettas.flatMap { $0.allShades }
    }
}

// MARK: - Palette

protocol Palette {
    associatedtype T

    var primary: T { get }
    var shade50: T { get }
    var shade100: T { get }
    var shade200: T { get }
    var shade300: T { get }
    var shade400: T { get }
    var shade500: T { get }
    var shade600: T { get }
    var shade700: T { get }
    var shade800: T { get }
    var shade900: T { get }

    var allShades: [T] { get }
}

extension Palette {
    var allShades: [T] {
        [
            shade50,
            shade100,
            shade200,
            shade300,
            shade400,
            shade500,
            shade600,
            shade700,
            shade800,
            shade900,
        ]
    }
}

// MARK: - DefaultPalette

public struct DefaultPalette: Hashable, Sendable, Palette {
    private nonisolated(unsafe) let _primary: KeyPath<DefaultPalette, DefaultColor>
    public var primary: DefaultColor {
        self[keyPath: _primary]
    }

    public let shade50: DefaultColor
    public let shade100: DefaultColor
    public let shade200: DefaultColor
    public let shade300: DefaultColor
    public let shade400: DefaultColor
    public let shade500: DefaultColor
    public let shade600: DefaultColor
    public let shade700: DefaultColor
    public let shade800: DefaultColor
    public let shade900: DefaultColor

    fileprivate init(
        primary: KeyPath<DefaultPalette, DefaultColor>,
        shade50: DefaultColor,
        shade100: DefaultColor,
        shade200: DefaultColor,
        shade300: DefaultColor,
        shade400: DefaultColor,
        shade500: DefaultColor,
        shade600: DefaultColor,
        shade700: DefaultColor,
        shade800: DefaultColor,
        shade900: DefaultColor
    ) {
        _primary = primary
        self.shade50 = shade50
        self.shade100 = shade100
        self.shade200 = shade200
        self.shade300 = shade300
        self.shade400 = shade400
        self.shade500 = shade500
        self.shade600 = shade600
        self.shade700 = shade700
        self.shade800 = shade800
        self.shade900 = shade900
    }
}

// MARK: - DefaultPalette Proxy

extension DefaultPalette {
    var uiKit: DefaultPaletteUIKitProxy {
        DefaultPaletteUIKitProxy(self)
    }

    var swiftUI: DefaultPaletteSwiftUIProxy {
        DefaultPaletteSwiftUIProxy(self)
    }
}

// MARK: - DefaultColor

public struct DefaultColor: Sendable {
    public let name: String

    // MARK: - LifeCycle

    fileprivate init(_ name: String) {
        self.name = name
        uiColor = UIColor(
            named: name,
            in: .module,
            compatibleWith: nil
        )!
        color = SwiftUI.Color(
            name,
            bundle: .module
        )
    }

    // MARK: - UIKit

    public let uiColor: UIColor

    public func uiColor(compatibleWith traitCollection: UITraitCollection) -> UIColor {
        guard let color = UIColor(named: name, in: .main, compatibleWith: traitCollection) else {
            fatalError("Unable to load color asset named \(name).")
        }
        return color
    }

    // MARK: - SwiftUI

    public let color: SwiftUI.Color
}

// MARK: - DefaultColor Hashable

extension DefaultColor: Hashable {
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(name)
    }

    public static func == (lhs: DefaultColor, rhs: DefaultColor) -> Bool {
        return lhs.name == rhs.name
    }
}

// MARK: - UIKit extension

public extension UIKit.UIColor {
    convenience init?(asset: DefaultColor) {
        self.init(
            named: asset.name,
            in: .module,
            compatibleWith: nil
        )
    }
}

// MARK: - SwiftUI extension

public extension SwiftUI.Color {
    init(asset: DefaultColor) {
        self.init(
            asset.name,
            bundle: .module
        )
    }
}

// MARK: - Preview

#if DEBUG
    #Preview {
        ScrollView {
            LazyVStack {
                ForEach(DefaultColors.allColors, id: \.self) { item in
                    RoundedRectangle(cornerRadius: .radius8)
                        .fill(item.color)
                        .frame(height: 100)
                        .overlay {
                            RoundedRectangle(cornerRadius: .radius8)
                                .stroke(.blue, lineWidth: .border1)
                        }
                        .overlay {
                            Text(item.name)
                                .font(.title2)
                        }
                        .padding(.horizontal)
                }
            }
        }
    }
#endif
