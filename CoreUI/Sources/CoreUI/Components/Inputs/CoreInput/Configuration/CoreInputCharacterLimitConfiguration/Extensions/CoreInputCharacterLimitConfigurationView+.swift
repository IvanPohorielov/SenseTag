//
//  CoreInputCharacterLimitConfigurationView+.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 25.12.2024.
//

import SwiftUI

public extension View {
    
    func inputCharacterLimitConfiguration(_ configuration: CoreInputCharacterLimitConfiguration?) -> some View {
        environment(\.inputCharacterLimitConfiguration, configuration)
    }
}
