//
//  LinkButton.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 20.12.2024.
//

import SwiftUI
import FoundationUI

public struct LinkButton<Icon: View>: ButtonCore, LinkButtonEnvProtocol, Loadable {
    
    let text: String?
    
    let icon: Icon?
    
    let action: () -> Void
    
    // MARK: - Properties
    
    @Environment(\.linkButtonStyle)
    var style: LinkButtonStyle
    
    @Environment(\.linkButtonSize)
    var size: LinkButtonSize
    
    @Environment(\.isEnabled)
    var isEnabled: Bool
    
    // MARK: - Loadable
    
    @Environment(\.isLoading)
    public var isLoading: Bool
    
    @Environment(\.isLoadingEnabled)
    public var isLoadingEnabled: Bool
    
    // MARK: - Views
    
    public var body : some View {
        body()
    }
}

// MARK: - Init

public extension LinkButton {
    
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
        _ content: ButtonCoreContent,
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

public extension LinkButton where Icon == Image {
    
    init(
        _ content: ButtonCoreContent,
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

#Preview("LinkButtonPreview") {
    LinkButtonPreview()
}

#endif
