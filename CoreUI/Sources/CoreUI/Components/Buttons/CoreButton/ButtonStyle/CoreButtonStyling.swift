//
//  CoreButtonStyling.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 18.12.2024.
//


import SwiftUI

struct CoreButtonStyling<Style: CoreButtonStyle, Size: CoreButtonSize>: ButtonStyle {
    
    private var style: Style
    private var size: Size
    private var borderShape: CoreButtonBorderShape?
    private var isEnabled: Bool
    private var isFullWidth: Bool
    
    init(
        style: Style,
        size: Size,
        borderShape: CoreButtonBorderShape?,
        isEnabled: Bool,
        isFullWidth: Bool?
    ) {
        self.style = style
        self.size = size
        self.borderShape = borderShape
        self.isEnabled = isEnabled
        self.isFullWidth = isFullWidth ?? false
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        
        let state: CoreButtonState = CoreButtonState.getState(
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
                if
                    let backgroundColor = style.backgroundColor(for: state),
                    let borderShape = borderShape?.shape(coreRadius: size.cornerRadius)
                {
                    borderShape
                        .fill(backgroundColor)
                }
            }
            .overlay {
                if
                    let borderColor = style.borderColor(for: state),
                    let borderShape = borderShape?.shape(coreRadius: size.cornerRadius)
                {
                    borderShape
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
