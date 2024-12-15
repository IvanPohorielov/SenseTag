//
//  Spacing.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 15.12.2024.
//

import UIKit

public struct DefaultSpacings: Sendable {
    static public let spacer2: CGFloat = 2.0
    static public let spacer4: CGFloat = 4.0
    static public let spacer8: CGFloat = 8.0
    static public let spacer12: CGFloat = 12.0
    static public let spacer16: CGFloat = 16.0
    static public let spacer24: CGFloat = 24.0
    static public let spacer32: CGFloat = 32.0
    static public let spacer40: CGFloat = 40.0
    static public let spacer48: CGFloat = 48.0
    static public let spacer56: CGFloat = 56.0
}

public extension CGFloat {
    static let spacer2:  CGFloat = DefaultSpacings.spacer2
    static let spacer4:  CGFloat = DefaultSpacings.spacer4
    static let spacer8:  CGFloat = DefaultSpacings.spacer8
    static let spacer12: CGFloat = DefaultSpacings.spacer12
    static let spacer16: CGFloat = DefaultSpacings.spacer16
    static let spacer24: CGFloat = DefaultSpacings.spacer24
    static let spacer32: CGFloat = DefaultSpacings.spacer32
    static let spacer40: CGFloat = DefaultSpacings.spacer40
    static let spacer48: CGFloat = DefaultSpacings.spacer48
    static let spacer56: CGFloat = DefaultSpacings.spacer56
}
