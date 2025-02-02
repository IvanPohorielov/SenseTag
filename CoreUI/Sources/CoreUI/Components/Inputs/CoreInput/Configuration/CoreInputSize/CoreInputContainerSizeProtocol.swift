//
//  CoreInputContainerSizeProtocol.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 25.12.2024.
//

import FoundationUI
import SwiftUI

protocol CoreInputContainerSizeProtocol: Hashable, Sendable {
    var containerCornerRadius: CGFloat { get }
    var containerBorderWidth: CGFloat { get }
    var captionStackSpacing: CGFloat { get }
    var contentVerticalPadding: CGFloat { get }
    var contentHorizontalPadding: CGFloat { get }
    var containerStackSpacing: CGFloat { get }

    var labelFont: Font { get }
    var captionFont: Font { get }
    var counterFont: Font { get }
}
