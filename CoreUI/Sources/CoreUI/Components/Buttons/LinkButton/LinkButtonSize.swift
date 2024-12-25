//
//  LinkButtonSize.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 20.12.2024.
//

import Foundation
import struct SwiftUI.Font
import FoundationUI

public struct LinkButtonSize: CoreButtonSize {
    
    let lineLimit: Int?
    
    let font: Font
    
    let iconSize: CGFloat
    
    let borderWidth: CGFloat = .zero
    
    let cornerRadius: CGFloat = .zero
    
    let contentIdealHeight: CGFloat
    
    let contentVerticalPadding: CGFloat = .zero
    
    let contentHorizontalPadding: CGFloat = .zero
    
    let mainStackSpacing: CGFloat
    
    public init(
        lineLimit: Int?,
        font: Font,
        iconSize: CGFloat,
        contentIdealHeight: CGFloat,
        mainStackSpacing: CGFloat
    ) {
        self.lineLimit = lineLimit
        self.font = font
        self.iconSize = iconSize
        self.contentIdealHeight = contentIdealHeight
        self.mainStackSpacing = mainStackSpacing
    }
    
}

public extension LinkButtonSize {

    static let large: LinkButtonSize = LinkButtonSize(
        lineLimit: 1,
        font: .senseBodyL,
        iconSize: .icon24,
        contentIdealHeight: 32.0,
        mainStackSpacing: .spacer16
    )
    
    static let regular: LinkButtonSize = LinkButtonSize(
        lineLimit: 1,
        font: .senseBody,
        iconSize: .icon24,
        contentIdealHeight: 24.0,
        mainStackSpacing: .spacer8
    )
    
    static let compact: LinkButtonSize = LinkButtonSize(
        lineLimit: 1,
        font: .senseCaption,
        iconSize: .icon16,
        contentIdealHeight: 16.0,
        mainStackSpacing: .spacer4
    )
    
}
