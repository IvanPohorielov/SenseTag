//
//  CoreInputEnviroment+.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 20.12.2024.
//

import SwiftUI

extension EnvironmentValues {
    @Entry
    var inputSize: CoreInputSize = .regular

    var inputContainerSize: any CoreInputContainerSizeProtocol {
        inputSize
    }

    @Entry
    var inputStyle: CoreInputStyle = .regular

    var inputContainerStyle: any CoreInputContainerStyleProtocol {
        inputStyle
    }

    @Entry
    var inputCharacterLimitConfiguration: CoreInputCharacterLimitConfiguration? = nil

    @Entry
    var inputClearButtonEnabled: Bool = false

    @Entry
    var inputClearButtonAction: CoreInputClearAction?

    @Entry
    var inputRequired: Bool = false
}
