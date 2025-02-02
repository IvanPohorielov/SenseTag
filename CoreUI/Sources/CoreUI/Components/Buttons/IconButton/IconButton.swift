//
//  IconButton.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 20.12.2024.
//

import FoundationUI
import SwiftUI

public struct IconButton<Icon: View>: CoreButton, IconButtonEnvProtocol, Loadable {
    let text: String? = nil

    let icon: Icon?

    let action: () -> Void

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

public extension IconButton {
    init(
        @ViewBuilder iconBuilder: () -> Icon = { EmptyView?(nil) },
        action: @escaping @MainActor () -> Void
    ) {
        icon = iconBuilder()
        self.action = action
    }
}

public extension IconButton where Icon == Image {
    init(
        icon: ImageContent? = nil,
        action: @escaping @MainActor () -> Void
    ) {
        if let icon {
            self.icon = Image(icon)
        } else {
            self.icon = nil
        }
        self.action = action
    }
}

#if DEBUG

    #Preview("IconButtonPreview") {
        IconButtonPreview()
    }

#endif
