//
//  CoreInputSize.swift
//
//
//  Created Ivan Pohorielov on 23.01.2024.
//  Copyright © 2024 Evo.company. All rights reserved.
//

import SwiftUI
import FoundationUI

public struct CoreInputSize: Hashable, Sendable, CoreInputContainerSizeProtocol {
    
    // MARK: - Properties
    
    let containerCornerRadius: CGFloat
    let containerBorderWidth: CGFloat
    
    let containerStackSpacing: CGFloat
    
    let fontStyle: Font.TextStyle
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
        fontStyle: Font.TextStyle,
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
        self.fontStyle = font.textStyle
        self.font = font.font
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
}

// MARK: - Catalog values

public extension CoreInputSize {
    
    static let regular: CoreInputSize = CoreInputSize(
        containerCornerRadius: .radius8,
        containerBorderWidth: .border1,
        containerStackSpacing: .spacer4,
        font: .body,
        labelFont: .senseBody,
        captionFont: .senseBody,
        counterFont: .senseBody,
        contentIdealHeight: 24.0,
        contentVerticalPadding: .spacer8,
        contentHorizontalPadding: .spacer16,
        captionStackSpacing: .spacer4,
        inputStackSpacing: .spacer8,
        leftViewSize: .icon24,
        rightViewSize: .icon24
    )
}
