//
//  IconButton.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 20.12.2024.
//

import FoundationUI
import SwiftUI

public struct IconButton<Icon: View, Label: View>: CoreButton, IconButtonEnvProtocol, Loadable {
    
    let label: Label?

    let icon: Icon?

    let action: @MainActor @Sendable () -> Void

    // MARK: - Configuration

    @Environment(\.iconButtonStyle)
    var style: IconButtonStyle

    @Environment(\.iconButtonSize)
    var size: IconButtonSize

    @Environment(\.isEnabled)
    var isEnabled: Bool

    @Environment(\.buttonBorderShape)
    var borderShape: CoreButtonBorderShape

    // MARK: - Loadable

    @Environment(\.isLoading)
    public var isLoading: Bool

    @Environment(\.isLoadingEnabled)
    public var isLoadingEnabled: Bool

    // MARK: - Views

    public var body: some View {
        body(
            borderShape: borderShape
        )
    }
}

// MARK: - Init

public extension IconButton where Label == EmptyView {
    init(
        @ViewBuilder iconBuilder: () -> Icon,
        action: @escaping @MainActor @Sendable () -> Void
    ) {
        self.label = EmptyView()
        self.icon = iconBuilder()
        self.action = action
    }
}

public extension IconButton where Icon == Image, Label == EmptyView {
    
    init(
        icon: ImageContent?,
        action: @escaping @MainActor @Sendable () -> Void
    ) {
        self.label = EmptyView()
        self.icon = Image(icon)?.resizable()
        self.action = action
    }
    
    init(
        icon: ImageResource,
        action: @escaping @MainActor @Sendable () -> Void
    ) {
        self.label = EmptyView()
        self.icon = Image(icon)?.resizable()
        self.action = action
    }
}

#if DEBUG

    #Preview("IconButtonPreview") {
        IconButtonPreview()
    }

#endif
