//
//  CoreButtonBorderShapeView+.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 03.03.2025.
//

import SwiftUI

public extension View {
    func buttonBorderShape(_ style: CoreButtonBorderShape) -> some View {
        environment(\.buttonBorderShape, style)
    }
}
