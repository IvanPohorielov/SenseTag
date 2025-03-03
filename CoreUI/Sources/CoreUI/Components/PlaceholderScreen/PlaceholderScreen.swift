//
//  PromEmptyScreen.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 03.03.2025.
//

import SwiftUI
import FoundationUI

public struct PlaceholderScreen<
    Illustration: View,
    Title: View,
    Label: View,
    Actions: View
>: View, PlaceholderScreenEnvProtocol {
    
    private let illustration: Illustration?
    private let title: Title
    private let label: Label?
    private let actions: Actions?
    
    // MARK: - Configuration
    
    @Environment(\.placeholderScreenLayout)
    var layout: PlaceholderScreenLayout
    
    // MARK: - Views
    
    public var body: some View {
        DefaultBackground {
            VStack(
                alignment: .center,
                spacing: layout.mainStackSpacing) {
                    
                    illustrationCast
                        .accessibilityIdentifier(Accessibility.illustrationView.rawValue)
                    
                    textSection
                    
                    if let actions {
                        VStack(spacing: layout.buttonStackSpacing) {
                            actions
                        }
                    }
                }
                .padding(
                    .horizontal,
                    layout.contentHorizontalPadding
                )
        }
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier(Accessibility.PlaceholderScreen.rawValue)
    }
    
    @ViewBuilder
    private var illustrationCast: some View {
        switch illustration {
        case let illustration as Image:
            illustration
                .resizable()
                .frame(
                    width: layout.illustrationSize,
                    height: layout.illustrationSize
                )
        default:
            illustration
        }
    }
    
    private var textSection: some View {
        VStack(spacing: layout.textStackSpacing) {
            
            title
                .accessibilityIdentifier(Accessibility.titleView.rawValue)
            
            label
                .accessibilityIdentifier(Accessibility.subtitleView.rawValue)
        }
    }
}

// MARK: - Init

extension PlaceholderScreen {
    public init(
        @ViewBuilder illustration: () -> Illustration = { EmptyView?(nil) },
        @ViewBuilder title: () -> Title = { EmptyView?(nil) },
        @ViewBuilder label: () -> Label = { EmptyView?(nil) },
        @ViewBuilder actions: () -> Actions = { EmptyView?(nil) }
    ) {
        self.illustration = illustration()
        self.title = title()
        self.label = label()
        self.actions = actions()
    }
}
