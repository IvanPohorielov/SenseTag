//
//  CoreInputCharacterLimitConfiguration.swift
//
//
//  Created by Ivan Pohorielov on 24.01.2024.
//

import SwiftUI

public struct CoreInputCharacterLimitConfiguration: Hashable, Sendable {
    
    let limit: Int
    let appearenceLimit: Int?

    public init(
        limit: Int,
        appearenceLimit: Int? = nil
    ) {
        self.limit = limit
        if let appearenceLimit {
            self.appearenceLimit = min(appearenceLimit, limit)
        } else {
            self.appearenceLimit = nil
        }
    }
}
