//
//  CoreInputContainerContentProtocol.swift
//  PromUI
//
//  Created by Ivan Pohorielov on 21.10.2024.
//

protocol CoreInputContainerContentProtocol {
    var label: String? { get }
    var caption: String? { get }
    var error: String? { get }
}

extension CoreInputContainerContentProtocol {
    var isError: Bool {
        error != nil
    }
}
