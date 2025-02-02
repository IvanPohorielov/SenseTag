//
//  LoadableEnviroment+.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 20.12.2024.
//

import SwiftUI

public extension EnvironmentValues {
    @Entry
    var isLoading: Bool = false

    @Entry
    var isLoadingEnabled: Bool = true
}
