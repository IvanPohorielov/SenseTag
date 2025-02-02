//
//  DefaultTextEditorView+.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 20.12.2024.
//

import SwiftUI

public extension View {
    func defaultTextEditorHeight(_ height: CGFloat) -> some View {
        environment(\.defaultTextEditorHeight, height)
    }
}
