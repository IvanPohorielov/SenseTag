//
//  ButtonCoreStyling.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 18.12.2024.
//


import SwiftUI

struct ButtonCoreStyling<Style: ButtonCoreStyle, Size: ButtonCoreSize>: ButtonStyle {
    
    private var style: Style
    private var size: Size
    private var borderShape: ButtonCoreBorderShape
    private var isEnabled: Bool
    private var isFullWidth: Bool
    
    init(
        style: Style,
        size: Size,
        borderShape: ButtonCoreBorderShape,
        isEnabled: Bool,
        isFullWidth: Bool
    ) {
        self.style = style
        self.size = size
        self.borderShape = borderShape
        self.isEnabled = isEnabled
        self.isFullWidth = isFullWidth
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        
        let state: ButtonCoreState = ButtonCoreState.getState(
            from: configuration,
            isEnabled: isEnabled
        )
        
        configuration
            .label
            .lineLimit(size.lineLimit)
            .padding(.vertical, size.contentVerticalPadding)
            .padding(.horizontal, size.contentHorizontalPadding)
            .frame(
                maxWidth: isFullWidth ? .infinity : nil,
                minHeight: size.idealContentHeight
            )
            .background {
                borderShape.shape(coreRadius: size.cornerRadius)
                    .fill(style.backgroundColor(for: state))
            }
            .overlay {
                if let borderColor = style.borderColor(for: state) {
                    borderShape.shape(coreRadius: size.cornerRadius)
                        .stroke(
                            borderColor,
                            lineWidth: size.borderWidth
                        )
                }
            }
            .foregroundStyle(
                style.foregroundColor(for: state)
            )
    }
}
