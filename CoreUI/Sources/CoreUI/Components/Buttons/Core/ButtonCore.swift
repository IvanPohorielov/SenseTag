//
//  ButtonCore.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 21.12.2024.
//

import SwiftUI

protocol ButtonCore: View {
    
    associatedtype Icon: View
    associatedtype Style: ButtonCoreStyle
    associatedtype Size: ButtonCoreSize
    
    var text: String { get }
    var icon: Icon? { get }
    var action: () -> Void { get }
    
    // MARK: - Configuration
    
    var style: Style { get }
    var size: Size { get }
    var isEnabled: Bool { get }
    
    // MARK: - Loadable
    
    var isLoading: Bool { get }
    var isLoadingEnabled: Bool { get }
}

extension ButtonCore {
    
    func body(
        borderShape: ButtonCoreBorderShape? = nil,
        isFullWidth: Bool? = nil
    ) -> some View {
        Button {
            self.action()
        } label: {
            ZStack{
                label
                    .opacity(isLoadingEnabled && isLoading ? 0 : 1)
                progress
                    .opacity(isLoadingEnabled && isLoading ? 1 : 0)
            }
            .animation(
                .easeInOut(duration: 0.2),
                value: isLoading
            )
        }
        .buttonStyle(
            ButtonCoreStyling(
                style: style,
                size: size,
                borderShape: borderShape,
                isEnabled: isEnabled,
                isFullWidth: isFullWidth
            )
        )
        .contentShape(Rectangle())
        .accessibilityIdentifier(ButtonCoreAccessibility.ButtonCore.rawValue)
    }
    
    @ViewBuilder
    private var progress: some View {
        ProgressView()
            .frame(
                width: size.iconSize,
                height: size.iconSize
            )
            .progressViewStyle(
                .circular
            )
            .tint(style.foregroundColorNormal)
            .accessibilityIdentifier(ButtonCoreAccessibility.progressView.rawValue)
    }
    
    @ViewBuilder
    private var iconView: some View {
        icon
            .frame(
                width: size.iconSize,
                height: size.iconSize
            )
            .accessibilityIdentifier(ButtonCoreAccessibility.iconView.rawValue)
    }
    
    @ViewBuilder
    private var textView: some View {
        Text(text)
            .font(size.font)
            .accessibilityIdentifier(ButtonCoreAccessibility.textView.rawValue)
    }
    
    @ViewBuilder
    private var label: some View {
        HStack(spacing: size.mainStackSpacing) {
            iconView
            textView
        }
    }
    
}
