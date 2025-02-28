//
//  CoreInputSize.swift
//
//
//  Created Ivan Pohorielov on 23.01.2024.
//  Copyright © 2024 Evo.company. All rights reserved.
//

import Foundation
import FoundationUI
import struct SwiftUI.Font
import class UIKit.UIFont

public struct CoreInputSize: Hashable, Sendable, CoreInputContainerSizeProtocol {
    // MARK: - Properties

    let containerCornerRadius: CGFloat
    let containerBorderWidth: CGFloat

    let containerStackSpacing: CGFloat

    let fontStyle: UIFont.TextStyle
    let font: Font
    let labelFont: Font
    let captionFont: Font
    let counterFont: Font

    let contentIdealHeight: CGFloat
    let contentVerticalPadding: CGFloat
    let contentHorizontalPadding: CGFloat

    let captionStackSpacing: CGFloat
    let inputStackSpacing: CGFloat

    let leftViewSize: CGFloat
    let rightViewSize: CGFloat

    // MARK: - LifeCycle

    init(
        containerCornerRadius: CGFloat,
        containerBorderWidth: CGFloat,
        containerStackSpacing: CGFloat,
        fontStyle: UIFont.TextStyle,
        font: Font,
        labelFont: Font,
        captionFont: Font,
        counterFont: Font,
        contentIdealHeight: CGFloat,
        contentVerticalPadding: CGFloat,
        contentHorizontalPadding: CGFloat,
        captionStackSpacing: CGFloat,
        inputStackSpacing: CGFloat,
        leftViewSize: CGFloat,
        rightViewSize: CGFloat
    ) {
        self.containerCornerRadius = containerCornerRadius
        self.containerBorderWidth = containerBorderWidth
        self.containerStackSpacing = containerStackSpacing
        self.fontStyle = fontStyle
        self.font = font
        self.labelFont = labelFont
        self.captionFont = captionFont
        self.counterFont = counterFont
        self.contentIdealHeight = contentIdealHeight
        self.contentVerticalPadding = contentVerticalPadding
        self.contentHorizontalPadding = contentHorizontalPadding
        self.captionStackSpacing = captionStackSpacing
        self.inputStackSpacing = inputStackSpacing
        self.leftViewSize = leftViewSize
        self.rightViewSize = rightViewSize
    }

    init(
        containerCornerRadius: CGFloat,
        containerBorderWidth: CGFloat,
        containerStackSpacing: CGFloat,
        font: DefaultFont,
        labelFont: DefaultFont,
        captionFont: DefaultFont,
        counterFont: DefaultFont,
        contentIdealHeight: CGFloat,
        contentVerticalPadding: CGFloat,
        contentHorizontalPadding: CGFloat,
        captionStackSpacing: CGFloat,
        inputStackSpacing: CGFloat,
        leftViewSize: CGFloat,
        rightViewSize: CGFloat
    ) {
        self.containerCornerRadius = containerCornerRadius
        self.containerBorderWidth = containerBorderWidth
        self.containerStackSpacing = containerStackSpacing
        fontStyle = font.uiTextStyle
        self.font = font.font
        self.labelFont = labelFont.font
        self.captionFont = captionFont.font
        self.counterFont = counterFont.font
        self.contentIdealHeight = contentIdealHeight
        self.contentVerticalPadding = contentVerticalPadding
        self.contentHorizontalPadding = contentHorizontalPadding
        self.captionStackSpacing = captionStackSpacing
        self.inputStackSpacing = inputStackSpacing
        self.leftViewSize = leftViewSize
        self.rightViewSize = rightViewSize
    }
}

// MARK: - Catalog values

public extension CoreInputSize {
    static let regular: CoreInputSize = .init(
        containerCornerRadius: .radius8,
        containerBorderWidth: .border1,
        containerStackSpacing: .spacer4,
        font: .labelM,
        labelFont: .labelL,
        captionFont: .labelM,
        counterFont: .labelM,
        contentIdealHeight: 24.0,
        contentVerticalPadding: .spacer8,
        contentHorizontalPadding: .spacer16,
        captionStackSpacing: .spacer4,
        inputStackSpacing: .spacer8,
        leftViewSize: .icon24,
        rightViewSize: .icon24
    )
}
