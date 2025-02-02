//
//  Border.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 15.12.2024.
//

import Foundation

public struct DefaultBorder: Sendable {
    public static let border05: CGFloat = 0.5
    public static let border1: CGFloat = 1
    public static let border2: CGFloat = 2
}

public extension CGFloat {
    static let border05: CGFloat = DefaultBorder.border05
    static let border1: CGFloat = DefaultBorder.border1
    static let border2: CGFloat = DefaultBorder.border2
}

public extension Double {
    static let border05: Double = .init(DefaultBorder.border05)
    static let border1: Double = .init(DefaultBorder.border1)
    static let border2: Double = .init(DefaultBorder.border2)
}
