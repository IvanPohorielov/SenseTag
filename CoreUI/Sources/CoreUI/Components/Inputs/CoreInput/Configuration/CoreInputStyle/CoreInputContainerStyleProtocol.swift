//
//  CoreInputContainerStyleProtocol.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 25.12.2024.
//

import FoundationUI
import SwiftUI

protocol CoreInputContainerStyleProtocol: Hashable, Sendable {
    var backgroundColorNormal: Color { get }
    var backgroundColorActive: Color { get }
    var backgroundColorError: Color { get }
    var backgroundColorDisabled: Color { get }

    var labelForegroundColor: Color { get }

    var captionForegroundColorNormal: Color { get }
    var captionForegroundColorActive: Color { get }
    var captionForegroundColorError: Color { get }
    var captionForegroundColorDisabled: Color { get }

    var counterForegroundColorNormal: Color { get }
    var counterForegroundColorActive: Color { get }
    var counterForegroundColorError: Color { get }
    var counterForegroundColorDisabled: Color { get }

    var outlineColorNormal: Color { get }
    var outlineColorActive: Color { get }
    var outlineColorError: Color { get }
    var outlineColorDisabled: Color { get }
}

extension CoreInputContainerStyleProtocol {
    func backgroundColor(for state: CoreInputState) -> Color {
        switch state {
        case .idle:
            return backgroundColorNormal
        case .active:
            return backgroundColorActive
        case .error:
            return backgroundColorError
        case .disabled:
            return backgroundColorDisabled
        }
    }

    func captionForegroundColor(for state: CoreInputState) -> Color {
        switch state {
        case .idle:
            return captionForegroundColorNormal
        case .active:
            return captionForegroundColorActive
        case .error:
            return captionForegroundColorError
        case .disabled:
            return captionForegroundColorDisabled
        }
    }

    func counterForegroundColor(for state: CoreInputState) -> Color {
        switch state {
        case .idle:
            return counterForegroundColorNormal
        case .active:
            return counterForegroundColorActive
        case .error:
            return counterForegroundColorError
        case .disabled:
            return captionForegroundColorDisabled
        }
    }

    func outlineColor(for state: CoreInputState) -> Color {
        switch state {
        case .idle:
            return outlineColorNormal
        case .active:
            return outlineColorActive
        case .error:
            return outlineColorError
        case .disabled:
            return outlineColorDisabled
        }
    }
}
