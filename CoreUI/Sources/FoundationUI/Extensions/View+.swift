//
//  View+.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 24.03.2025.
//

import SwiftUI

public extension View {
    func senseSheet() -> some View {
        presentationCornerRadius(40.0)
        .presentationDetents([.medium, .large])
        .presentationBackground(.regularMaterial)
    }
}
