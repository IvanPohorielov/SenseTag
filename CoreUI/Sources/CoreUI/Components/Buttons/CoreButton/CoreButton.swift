//
//  CoreButton.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 21.12.2024.
//

import SwiftUI
import FoundationUI

protocol CoreButton: View {
    
    associatedtype Icon: View
    associatedtype Label: View
    associatedtype Style: CoreButtonStyle
    associatedtype Size: CoreButtonSize
    
    var label: Label? { get }
    var icon: Icon? { get }
    var action: @MainActor () -> Void { get }

    // MARK: - Configuration

    var style: Style { get }
    var size: Size { get }
    var isEnabled: Bool { get }

    // MARK: - Loadable

    var isLoading: Bool { get }
    var isLoadingEnabled: Bool { get }
}

extension CoreButton {
    private var _iconSize: CGFloat {
        UIFontMetrics(forTextStyle: size.fontStyle).scaledValue(for: size.iconSize)
    }

    func body(
        borderShape: CoreButtonBorderShape? = nil,
        isFullWidth: Bool? = nil
    ) -> some View {
        Button {
            DefaultHaptics.sendHapticFeedback(.selection)
            self.action()
        } label: {
            ZStack {
                content
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
            CoreButtonStyling(
                style: style,
                size: size,
                borderShape: borderShape,
                isEnabled: isEnabled,
                isFullWidth: isFullWidth
            )
        )
        .contentShape(Rectangle())
        .accessibilityIdentifier(CoreButtonAccessibility.CoreButton.rawValue)
    }

    @ViewBuilder
    private var progress: some View {
        ProgressView()
            .frame(
                width: _iconSize,
                height: _iconSize
            )
            .progressViewStyle(
                .circular
            )
            .tint(style.foregroundColorNormal)
            .accessibilityIdentifier(CoreButtonAccessibility.progressView.rawValue)
    }

    @ViewBuilder
    private var iconView: some View {
        icon
            .scaledToFit()
            .frame(
                width: _iconSize,
                height: _iconSize
            )
            .accessibilityIdentifier(CoreButtonAccessibility.iconView.rawValue)
    }

    @ViewBuilder
    private var labelView: some View {
        label
            .font(size.font)
            .lineLimit(size.lineLimit)
            .accessibilityIdentifier(CoreButtonAccessibility.textView.rawValue)
    }

    @ViewBuilder
    private var content: some View {
        HStack(spacing: size.mainStackSpacing) {
            iconView
            labelView
        }
    }
}
