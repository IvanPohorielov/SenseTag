//
//  View+.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 20.12.2024.
//

import SwiftUI

public extension View {
    
    func inputCharacterLimitConfiguration(_ configuration: CoreInputCharacterLimitConfiguration?) -> some View {
        environment(\.inputCharacterLimitConfiguration, configuration)
    }
    
    func inputSize(_ size: CoreInputSize) -> some View {
        environment(\.inputSize, size)
    }
    
    func inputStyle(_ style: CoreInputStyle) -> some View {
        environment(\.inputStyle, style)
    }
    
    func inputClearButtonEnabled(_ enabled: Bool) -> some View {
        environment(\.inputClearButtonEnabled, enabled)
    }
    
    func inputClearButtonAction(_ action: @escaping @MainActor () -> Void) -> some View {
        environment(\.inputClearButtonAction, CoreInputClearAction(action))
    }
    
    func inputRequired(_ required: Bool) -> some View {
        environment(\.inputRequired, required)
    }
    
}
