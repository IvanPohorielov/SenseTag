//
//  Radius.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 15.12.2024.
//

import Foundation

public struct DefaultRadius: Sendable {
    static public let radius2: CGFloat = 2
    static public let radius4: CGFloat = 4
    static public let radius6: CGFloat = 6
    static public let radius8: CGFloat = 8
    static public let radius10: CGFloat = 10
    static public let radius12: CGFloat = 12
    static public let radius14: CGFloat = 14
    static public let radius16: CGFloat = 16
    static public let radius18: CGFloat = 18
    static public let radius20: CGFloat = 20
    static public let radius22: CGFloat = 22
    static public let radius24: CGFloat = 24
}

public extension CGFloat {
    static let radius2: CGFloat = DefaultRadius.radius2
    static let radius4: CGFloat = DefaultRadius.radius4
    static let radius6: CGFloat = DefaultRadius.radius6
    static let radius8: CGFloat = DefaultRadius.radius8
    static let radius10: CGFloat = DefaultRadius.radius10
    static let radius12: CGFloat = DefaultRadius.radius12
    static let radius14: CGFloat = DefaultRadius.radius14
    static let radius16: CGFloat = DefaultRadius.radius16
    static let radius18: CGFloat = DefaultRadius.radius18
    static let radius20: CGFloat = DefaultRadius.radius20
    static let radius22: CGFloat = DefaultRadius.radius22
    static let radius24: CGFloat = DefaultRadius.radius24
}
