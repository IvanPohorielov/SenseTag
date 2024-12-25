//
//  DefaultButtonSize.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 20.12.2024.
//

import Foundation
import struct SwiftUI.Font
import FoundationUI

public struct DefaultButtonSize: CoreButtonSize {
    
    let lineLimit: Int?
    
    let font: Font
    
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
        self.iconSize = iconSize
        self.borderWidth = borderWidth
        self.cornerRadius = cornerRadius
        self.contentIdealHeight = contentIdealHeight
        self.contentVerticalPadding = contentVerticalPadding
        self.contentHorizontalPadding = contentHorizontalPadding
        self.mainStackSpacing = mainStackSpacing
    }
    
}

public extension DefaultButtonSize {

    static let large: DefaultButtonSize = DefaultButtonSize(
        lineLimit: 1,
        font: .senseLabelM,
        iconSize: .icon24,
        borderWidth: .border1,
        cornerRadius: .radius16,
        contentIdealHeight: 56.0,
        contentVerticalPadding: .spacer16,
        contentHorizontalPadding: .spacer24,
        mainStackSpacing: .spacer16
    )
    
    static let regular: DefaultButtonSize = DefaultButtonSize(
        lineLimit: 1,
        font: .senseLabelM,
        iconSize: .icon24,
        borderWidth: .border1,
        cornerRadius: .radius8,
        contentIdealHeight: 40.0,
        contentVerticalPadding: .spacer8,
        contentHorizontalPadding: .spacer16,
        mainStackSpacing: .spacer8
    )
    
    static let compact: DefaultButtonSize = DefaultButtonSize(
        lineLimit: 1,
        font: .senseLabelM,
        iconSize: .icon16,
        borderWidth: .border1,
        cornerRadius: .radius8 ,
        contentIdealHeight: 32.0,
        contentVerticalPadding: .spacer8,
        contentHorizontalPadding: .spacer16,
        mainStackSpacing: .spacer4
    )
    
}
