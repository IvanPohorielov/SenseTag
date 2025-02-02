//
//  Icon.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 15.12.2024.
//

import Foundation
import SwiftUI

public struct DefaultIcon: Sendable {
    public static let icon16: CGFloat = 16.0
    public static let icon24: CGFloat = 24.0
}

public extension CGFloat {
    static let icon16: CGFloat = DefaultIcon.icon16
    static let icon24: CGFloat = DefaultIcon.icon24
}

public extension View {
    func frameIcon16() -> some View {
        frame(
            width: .icon16,
            height: .icon16
        )
    }

    func frameIcon24() -> some View {
        frame(
            width: .icon24,
            height: .icon24
        )
    }
}
