//
//  View+.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 20.12.2024.
//

import SwiftUI

public extension View {
    
    func isLoading(_ loading: Bool) -> some View {
        environment(\.isLoading, loading)
    }
    
    func loadingDisabled(_ disabled: Bool) -> some View {
        environment(\.isLoadingEnabled, !disabled)
    }
}
