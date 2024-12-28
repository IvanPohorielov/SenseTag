//
//  DefaultButton.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 20.12.2024.
//

import SwiftUI
import FoundationUI



public struct DefaultButton<Icon: View>: CoreButton, DefaultButtonEnvProtocol, Loadable {
    
    let text: String?
    
    let icon: Icon?
    
    let action: () -> Void
    
    // MARK: - Configuration
    
    @Environment(\.buttonStyle)
    var style: DefaultButtonStyle
    
    @Environment(\.buttonSize)
    var size: DefaultButtonSize
    
    @Environment(\.isEnabled)
    var isEnabled: Bool
    
    @Environment(\.buttonFullWidth)
    var isFullWidth: Bool
    
    @Environment(\.buttonBorderShape)
    var borderShape: CoreButtonBorderShape
    
    // MARK: - Loadable
    
    @Environment(\.isLoading)
    public var isLoading: Bool
    
    @Environment(\.isLoadingEnabled)
    public var isLoadingEnabled: Bool
    
    // MARK: - Properties
    
    @ScaledMetric
    var iconSize: CGFloat = 0.0
    
    // MARK: - Views
    
    public var body : some View {
        body(
            borderShape: borderShape,
            isFullWidth: isFullWidth
        )
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
        
        self._iconSize = ScaledMetric(wrappedValue: size.iconSize, relativeTo: size.fontStyle)
    }
    
    init(
        _ content: CoreButtonContent,
        @ViewBuilder iconBuilder: (ImageContent?) -> Icon = { content in
            Image(content)?
                .resizable()
        },
        action: @escaping @MainActor () -> Void
    ) {
        self.text = content.text
        self.icon = iconBuilder(content.icon)
        self.action = action
        
        self._iconSize = ScaledMetric(wrappedValue: size.iconSize, relativeTo: size.fontStyle)
    }
    
}

public extension DefaultButton where Icon == Image {
    
    init(
        _ content: CoreButtonContent,
        action: @escaping @MainActor () -> Void
    ) {
        self.text = content.text
        if let icon = content.icon {
            self.icon = Image(icon)
        } else {
            self.icon = nil
        }
        self.action = action
        
        self._iconSize = ScaledMetric(wrappedValue: size.iconSize, relativeTo: size.fontStyle)
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
        
        self._iconSize = ScaledMetric(wrappedValue: size.iconSize, relativeTo: size.fontStyle)
    }
}

#if DEBUG

#Preview("DefaultButtonPreview") {
    DefaultButtonPreview()
}

#endif
