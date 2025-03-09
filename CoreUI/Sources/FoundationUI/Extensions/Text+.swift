//
//  Text+.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 03.03.2025.
//

import SwiftUI

public extension Text {

    init?(_ content: LocalizedStringKey?) {
        if let content {
            self.init(content)
        } else {
            return nil
        }
    }
}
