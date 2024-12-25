//
//  CoreInputConfigurationView+.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 25.12.2024.
//

import SwiftUI

public extension View {
    
    func inputClearButtonEnabled(_ enabled: Bool) -> some View {
        environment(\.inputClearButtonEnabled, enabled)
    }
    
    func inputRequired(_ required: Bool) -> some View {
        environment(\.inputRequired, required)
    }
}
