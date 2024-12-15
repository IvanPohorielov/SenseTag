//
//  Border.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 15.12.2024.
//

import Foundation

public struct DefaultBorder: Sendable {
    static public let border05: CGFloat = 0.5
    static public let border1: CGFloat = 1
    static public let border2: CGFloat = 2
}

public extension CGFloat {
    static let border05: CGFloat = DefaultBorder.border05
    static let border1: CGFloat = DefaultBorder.border1
    static let border2: CGFloat = DefaultBorder.border2
}

public extension Double {
    static let border05: Double = Double(DefaultBorder.border05)
    static let border1:  Double = Double(DefaultBorder.border1)
    static let border2: Double = Double(DefaultBorder.border2)
}
