//
//  PlaceholderScreenView+.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 20.12.2024.
//

import SwiftUI

public extension View {

    func placeholderScreenLayout(_ style: PlaceholderScreenLayout) -> some View {
        environment(\.placeholderScreenLayout, style)
    }
}
