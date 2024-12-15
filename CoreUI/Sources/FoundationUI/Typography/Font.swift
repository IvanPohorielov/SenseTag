//
//  Fonts.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 15.12.2024.
//

import Foundation
import UIKit
import SwiftUI

public enum DefaultFonts: String, Hashable, Sendable, CaseIterable {
    
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
    
    // MARK: - UIFont
    
    public var uiFont: UIFont {
        switch self {
        case .hZero:
            return UIFont.systemFont(
                ofSize: 36.0,
                weight: .bold
            )
        case .hOne:
            return UIFont.systemFont(
                ofSize: 24.0,
                weight: .bold
            )
        case .hTwo:
            return UIFont.systemFont(
                ofSize: 20.0,
                weight: .semibold
            )
        case .hThree:
            return UIFont.systemFont(
                ofSize: 18.0,
                weight: .medium
            )
        case .labelL:
            return UIFont.systemFont(
                ofSize: 16.0,
                weight: UIFont.Weight.medium
            )
        case .labelM:
            return UIFont.systemFont(
                ofSize: 14.0,
                weight: .medium
            )
        case .labelS:
            return UIFont.systemFont(
                ofSize: 10.0,
                weight: .medium
            )
        case .bodyL:
            return UIFont.systemFont(
                ofSize: 16.0,
                weight: .regular
            )
        case .body:
            return UIFont.systemFont(
                ofSize: 14.0,
                weight: .regular
            )
        case .caption:
            return UIFont.systemFont(
                ofSize: 12.0,
                weight: .regular
            )
        }
    }
    
    // MARK: - Font

    public var font: Font {
        switch self {
        case .hZero:
            return Font.system(
                size: 36.0,
                weight: .bold,
                design: .default
            )
        case .hOne:
            return Font.system(
                size: 24.0,
                weight: .bold,
                design: .default
            )
        case .hTwo:
            return Font.system(
                size: 20.0,
                weight: .semibold,
                design: .default
            )
        case .hThree:
            return Font.system(
                size: 18.0,
                weight: .medium,
                design: .default
            )
        case .labelL:
            return Font.system(
                size: 16.0,
                weight: .medium,
                design: .default
            )
        case .labelM:
            return Font.system(
                size: 14.0,
                weight: .medium,
                design: .default
            )
        case .labelS:
            return Font.system(
                size: 10.0,
                weight: .medium,
                design: .default
            )
        case .bodyL:
            return Font.system(
                size: 16.0,
                weight: .regular,
                design: .default
            )
        case .body:
            return Font.system(
                size: 14.0,
                weight: .regular,
                design: .default
            )
        case .caption:
            return Font.system(
                size: 12.0,
                weight: .regular,
                design: .default
            )
        }
    }
}
