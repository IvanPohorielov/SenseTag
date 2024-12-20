//
//  DefaultButton.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 20.12.2024.
//

import SwiftUI
import FoundationUI

public struct DefaultButton<Icon: View>: View, DefaultButtonEnvProtocol, Loadable {
    
    // MARK: - DefaultButtonContentProtocol
    
    private let text: String
    
    private let icon: Icon?
    
    private let action: () -> Void
    
    // MARK: - Properties
    
    @Environment(\.defaultButtonStyle)
    var style: DefaultButtonStyle
    
    @Environment(\.defaultButtonSize)
    var size: DefaultButtonSize
    
    @Environment(\.defaultButtonFullWidth)
    var isFullWidth: Bool
    
    @Environment(\.isEnabled)
    var isEnabled: Bool
    
    @Environment(\.defaultButtonBorderShape)
    var borderShape: ButtonCoreBorderShape
    
    // MARK: - Loadable
    
    @Environment(\.isLoading)
    public var isLoading: Bool
    
    @Environment(\.isLoadingEnabled)
    public var isLoadingEnabled: Bool
    
    // MARK: - Views
    
    public var body : some View {
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
        .accessibilityIdentifier(Accessibility.DefaultButton.rawValue)
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
            .accessibilityIdentifier(Accessibility.progressView.rawValue)
    }
    
    @ViewBuilder
    private var iconView: some View {
        icon
            .frame(
                width: size.iconSize,
                height: size.iconSize
            )
            .accessibilityIdentifier(Accessibility.iconView.rawValue)
    }
    
    @ViewBuilder
    private var textView: some View {
        Text(text)
            .font(size.font)
            .accessibilityIdentifier(Accessibility.textView.rawValue)
    }
    
    @ViewBuilder
    private var label: some View {
        HStack(spacing: size.mainStackSpacing) {
            iconView
            textView
        }
    }
    
}

// MARK: - Init

public extension DefaultButton {
    
    init(
        text: String,
        @ViewBuilder iconBuilder: () -> Icon = { EmptyView?(nil) },
        action: @escaping @MainActor () -> Void
    ) {
        self.text = text
        self.icon = iconBuilder()
        self.action = action
    }
    
    init(
        _ content: DefaultButtonContent,
        @ViewBuilder iconBuilder: (ImageContent?) -> Icon = { content in
            Image(content)?
                .resizable()
        },
        action: @escaping @MainActor () -> Void
    ) {
        self.text = content.text
        self.icon = iconBuilder(content.icon)
        self.action = action
    }
    
}

public extension DefaultButton where Icon == Image {
    
    init(
        _ content: DefaultButtonContent,
        action: @escaping @MainActor () -> Void
    ) {
        self.text = content.text
        if let icon = content.icon {
            self.icon = Image(icon)
        } else {
            self.icon = nil
        }
        self.action = action
    }
    
    init(
        text: String,
        icon: ImageContent? = nil,
        action: @escaping @MainActor () -> Void
    ) {
        self.text = text
        if let icon {
            self.icon = Image(icon)
        } else {
            self.icon = nil
        }
        self.action = action
    }
}

#if DEBUG

#Preview("DefaultButtonPreview") {
    DefaultButtonPreview()
}

#endif
