//
//  DefaultButton.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 20.12.2024.
//

import FoundationUI
import SwiftUI

public struct DefaultButton<Icon: View, Label: View>: CoreButton, DefaultButtonEnvProtocol, Loadable {
    
    let label: Label?

    let icon: Icon?

    let action: @MainActor @Sendable () -> Void

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

    // MARK: - Views

    public var body: some View {
        body(
            borderShape: borderShape,
            isFullWidth: isFullWidth
        )
    }
}

// MARK: - Init

public extension DefaultButton {
    init(
        @ViewBuilder labelBuilder: () -> Label = { EmptyView?(nil) },
        @ViewBuilder iconBuilder: () -> Icon = { EmptyView?(nil) },
        action: @escaping @MainActor @Sendable () -> Void
    ) {
        self.label = labelBuilder()
        self.icon = iconBuilder()
        self.action = action
    }
}

public extension DefaultButton where Icon == Image, Label == Text {
    
    @_semantics("swiftui.init_with_localization")
    init(
        _ titleKey: LocalizedStringKey,
        icon: ImageContent? = nil,
        action: @escaping @MainActor @Sendable () -> Void
    ) {
        self.label = Text(titleKey)
        self.icon = Image(icon)?.resizable()
        self.action = action
    }
    
    @_disfavoredOverload
    init<S>(
        _ title: S,
        icon: ImageContent? = nil,
        action: @escaping @MainActor @Sendable () -> Void
    ) where S : StringProtocol {
        self.label = Text(title)
        self.icon = Image(icon)?.resizable()
        self.action = action
    }
    
    @_semantics("swiftui.init_with_localization")
    init(
        _ titleKey: LocalizedStringKey,
        icon: ImageResource?,
        action: @escaping @MainActor @Sendable () -> Void
    ) {
        self.label = Text(titleKey)
        if let icon  {
            self.icon = Image(icon)?.resizable()
        } else {
            self.icon = nil
        }
        self.action = action
    }
    
    @_disfavoredOverload
    init<S>(
        _ title: S,
        icon: ImageResource?,
        action: @escaping @MainActor @Sendable () -> Void
    ) where S : StringProtocol {
        self.label = Text(title)
        if let icon  {
            self.icon = Image(icon)?.resizable()
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
