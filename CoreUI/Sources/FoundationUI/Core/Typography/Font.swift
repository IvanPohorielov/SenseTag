//
//  Font.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 15.12.2024.
//

import Foundation
import SwiftUI
import UIKit

public enum DefaultFont: String, Hashable, Sendable, CaseIterable {
    /// 36 Bold
    case hZero
    /// 24 Bold
    case hOne
    /// 20 Semibold
    case hTwo
    /// 18 Medium
    case hThree
    /// 16 Medium
    case labelL
    /// 14 Medium
    case labelM
    /// 10 Medium
    case labelS
    /// 16 Regular
    case bodyL
    /// 14 Regular
    case body
    /// 12 Regular
    case caption

    // MARK: - Properties

    public var size: CGFloat {
        switch self {
        case .hZero: return 36.0
        case .hOne: return 24.0
        case .hTwo: return 20.0
        case .hThree: return 18.0
        case .labelL: return 16.0
        case .labelM: return 14.0
        case .labelS: return 10.0
        case .bodyL: return 16.0
        case .body: return 14.0
        case .caption: return 12.0
        }
    }

    public var uiWeight: UIFont.Weight {
        switch self {
        case .hZero, .hOne: return .bold
        case .hTwo: return .semibold
        case .hThree, .labelL, .labelM, .labelS: return .medium
        case .bodyL, .body, .caption: return .regular
        }
    }

    public var weight: Font.Weight {
        switch self {
        case .hZero, .hOne: return .bold
        case .hTwo: return .semibold
        case .hThree, .labelL, .labelM, .labelS: return .medium
        case .bodyL, .body, .caption: return .regular
        }
    }

    public var uiTextStyle: UIFont.TextStyle {
        switch self {
        case .hZero: return .largeTitle
        case .hOne: return .title1
        case .hTwo: return .title2
        case .hThree: return .title3
        case .labelL: return .headline
        case .labelM: return .subheadline
        case .labelS: return .footnote
        case .bodyL, .body: return .body
        case .caption: return .caption2
        }
    }

    public var textStyle: Font.TextStyle {
        switch self {
        case .hZero: return .largeTitle
        case .hOne: return .title
        case .hTwo: return .title2
        case .hThree: return .title3
        case .labelL: return .headline
        case .labelM: return .subheadline
        case .labelS: return .footnote
        case .bodyL, .body: return .body
        case .caption: return .caption2
        }
    }

    // MARK: - UIFont

    public var uiFont: UIFont {
        UIFontMetrics(forTextStyle: uiTextStyle)
            .scaledFont(
                for: UIFont.systemFont(
                    ofSize: size,
                    weight: uiWeight
                )
            )
    }

    // MARK: - Font

    public var font: Font {
        Font
            .custom(
                "HelveticaNeue", // workaround scalable font
                size: size,
                relativeTo: textStyle
            )
            .weight(weight)
    }
}

// MARK: - Preview

#if DEBUG
    #Preview {
        ScrollView {
            LazyVStack {
                ForEach(DefaultFont.allCases, id: \.self) { item in
                    RoundedRectangle(cornerRadius: .radius8)
                        .fill(.clear)
                        .frame(height: 100)
                        .overlay {
                            RoundedRectangle(cornerRadius: .radius8)
                                .stroke(.blue, lineWidth: .border1)
                        }
                        .overlay {
                            Text(item.rawValue)
                                .font(item.font)
                        }
                        .padding(.horizontal)
                }
            }
        }
    }
#endif
