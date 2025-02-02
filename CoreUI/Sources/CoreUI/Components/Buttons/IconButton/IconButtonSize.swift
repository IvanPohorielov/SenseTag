//
//  IconButtonSize.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 20.12.2024.
//

import Foundation
import FoundationUI
import struct SwiftUI.Font
import class UIKit.UIFont

public struct IconButtonSize: CoreButtonSize {
    let lineLimit: Int?

    let font: Font

    let fontStyle: UIFont.TextStyle

    let iconSize: CGFloat

    let borderWidth: CGFloat

    let cornerRadius: CGFloat

    let contentIdealHeight: CGFloat

    let contentVerticalPadding: CGFloat

    let contentHorizontalPadding: CGFloat

    let mainStackSpacing: CGFloat

    public init(
        lineLimit: Int?,
        font: Font,
        fontStyle: UIFont.TextStyle,
        iconSize: CGFloat,
        borderWidth: CGFloat,
        cornerRadius: CGFloat,
        contentIdealHeight: CGFloat,
        contentVerticalPadding: CGFloat,
        contentHorizontalPadding: CGFloat,
        mainStackSpacing: CGFloat
    ) {
        self.lineLimit = lineLimit
        self.font = font
        self.fontStyle = fontStyle
        self.iconSize = iconSize
        self.borderWidth = borderWidth
        self.cornerRadius = cornerRadius
        self.contentIdealHeight = contentIdealHeight
        self.contentVerticalPadding = contentVerticalPadding
        self.contentHorizontalPadding = contentHorizontalPadding
        self.mainStackSpacing = mainStackSpacing
    }

    public init(
        lineLimit: Int?,
        font: DefaultFont,
        iconSize: CGFloat,
        borderWidth: CGFloat,
        cornerRadius: CGFloat,
        contentIdealHeight: CGFloat,
        contentVerticalPadding: CGFloat,
        contentHorizontalPadding: CGFloat,
        mainStackSpacing: CGFloat
    ) {
        self.lineLimit = lineLimit
        self.font = font.font
        fontStyle = font.uiTextStyle
        self.iconSize = iconSize
        self.borderWidth = borderWidth
        self.cornerRadius = cornerRadius
        self.contentIdealHeight = contentIdealHeight
        self.contentVerticalPadding = contentVerticalPadding
        self.contentHorizontalPadding = contentHorizontalPadding
        self.mainStackSpacing = mainStackSpacing
    }
}

public extension IconButtonSize {
    static let large: IconButtonSize = .init(
        lineLimit: 1,
        font: .labelM,
        iconSize: .icon24,
        borderWidth: .border1,
        cornerRadius: .radius16,
        contentIdealHeight: 56.0,
        contentVerticalPadding: .spacer16,
        contentHorizontalPadding: .spacer16,
        mainStackSpacing: .spacer16
    )

    static let regular: IconButtonSize = .init(
        lineLimit: 1,
        font: .labelM,
        iconSize: .icon24,
        borderWidth: .border1,
        cornerRadius: .radius8,
        contentIdealHeight: 40.0,
        contentVerticalPadding: .spacer8,
        contentHorizontalPadding: .spacer8,
        mainStackSpacing: .spacer8
    )

    static let compact: IconButtonSize = .init(
        lineLimit: 1,
        font: .labelM,
        iconSize: .icon16,
        borderWidth: .border1,
        cornerRadius: .radius8,
        contentIdealHeight: 32.0,
        contentVerticalPadding: .spacer8,
        contentHorizontalPadding: .spacer8,
        mainStackSpacing: .spacer4
    )
}
