//
//  Radius.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 15.12.2024.
//

import Foundation

public struct DefaultRadius: Sendable {
    public static let radius2: CGFloat = 2
    public static let radius4: CGFloat = 4
    public static let radius6: CGFloat = 6
    public static let radius8: CGFloat = 8
    public static let radius10: CGFloat = 10
    public static let radius12: CGFloat = 12
    public static let radius14: CGFloat = 14
    public static let radius16: CGFloat = 16
    public static let radius18: CGFloat = 18
    public static let radius20: CGFloat = 20
    public static let radius22: CGFloat = 22
    public static let radius24: CGFloat = 24
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
