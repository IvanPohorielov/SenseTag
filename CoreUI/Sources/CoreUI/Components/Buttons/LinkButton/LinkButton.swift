//
//  LinkButton.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 20.12.2024.
//

import FoundationUI
import SwiftUI

public struct LinkButton<Icon: View, Label: View>: CoreButton, LinkButtonEnvProtocol, Loadable {
    
    let label: Label?

    let icon: Icon?

    let action: @MainActor @Sendable () -> Void


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

    public var body: some View {
        body()
    }
}

// MARK: - Init

public extension LinkButton {
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

public extension LinkButton where Icon == Image, Label == Text {
    
    @_semantics("swiftui.init_with_localization")
    init(
        _ titleKey: LocalizedStringKey,
        icon: ImageContent?,
        action: @escaping @MainActor @Sendable () -> Void
    ) {
        self.label = Text(titleKey)
        self.icon = Image(icon)
        self.action = action
    }
    
    @_disfavoredOverload
    init<S>(
        _ title: S,
        icon: ImageContent?,
        action: @escaping @MainActor @Sendable () -> Void
    ) where S : StringProtocol {
        self.label = Text(title)
        self.icon = Image(icon)
        self.action = action
    }
    
    @_semantics("swiftui.init_with_localization")
    init(
        _ titleKey: LocalizedStringKey,
        icon: ImageResource,
        action: @escaping @MainActor @Sendable () -> Void
    ) {
        self.label = Text(titleKey)
        self.icon = Image(icon)
        self.action = action
    }
    
    @_disfavoredOverload
    init<S>(
        _ title: S,
        icon: ImageResource,
        action: @escaping @MainActor @Sendable () -> Void
    ) where S : StringProtocol {
        self.label = Text(title)
        self.icon = Image(icon)
        self.action = action
    }
}

#if DEBUG

    #Preview("LinkButtonPreview") {
        LinkButtonPreview()
    }

#endif
