//
//  DefaultTextFieldEnvProtocol.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 28.12.2024.
//

import SwiftUI

@MainActor
protocol DefaultTextFieldEnvProtocol: CoreInputEnvProtocol {
    var clearButtonEnabled: Bool { get }

    var clearButtonAction: CoreInputClearAction? { get }
}
