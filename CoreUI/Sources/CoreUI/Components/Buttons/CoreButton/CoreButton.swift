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
    associatedtype Style: CoreButtonStyle
    associatedtype Size: CoreButtonSize

    var text: String? { get }
    var icon: Icon? { get }
    var action: () -> Void { get }

    // MARK: - Configuration

    var style: Style { get }
    var size: Size { get }
    var isEnabled: Bool { get }

    // MARK: - Loadable

    var isLoading: Bool { get }
    var isLoadingEnabled: Bool { get }

    // MARK: - Properties

    var iconSize: CGFloat { get } // Scaled metric
}

extension CoreButton {
    var iconSize: CGFloat {
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
                width: iconSize,
                height: iconSize
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
            .frame(
                width: iconSize,
                height: iconSize
            )
            .accessibilityIdentifier(CoreButtonAccessibility.iconView.rawValue)
    }

    @ViewBuilder
    private var textView: some View {
        if let text {
            Text(text)
                .font(size.font)
                .accessibilityIdentifier(CoreButtonAccessibility.textView.rawValue)
        }
    }

    @ViewBuilder
    private var label: some View {
        HStack(spacing: size.mainStackSpacing) {
            iconView
            textView
        }
    }
}
