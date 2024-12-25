//
//  CoreInputState.swift
//
//
//  Created by Ivan Pohorielov on 23.01.2024.
//

import Foundation

enum CoreInputState: String, Hashable, Sendable, CaseIterable {
    case idle
    case active
    case error
    case disabled
}
