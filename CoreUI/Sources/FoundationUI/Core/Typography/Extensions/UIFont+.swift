//
//  UIFont+.swift
//  CoreUI
//
//  Created by Ivan Pohorielov on 15.12.2024.
//

import class UIKit.UIFont

public extension UIFont {
    static var senseHZero: UIFont {
        return DefaultFont.hZero.uiFont
    }

    static var senseHOne: UIFont {
        return DefaultFont.hOne.uiFont
    }

    static var senseHTwo: UIFont {
        return DefaultFont.hTwo.uiFont
    }

    static var senseHThree: UIFont {
        return DefaultFont.hThree.uiFont
    }

    static var senseLabelL: UIFont {
        return DefaultFont.labelL.uiFont
    }

    static var senseLabelM: UIFont {
        return DefaultFont.labelM.uiFont
    }

    static var senseLabelS: UIFont {
        return DefaultFont.labelS.uiFont
    }

    static var senseBodyL: UIFont {
        return DefaultFont.bodyL.uiFont
    }

    static var senseBody: UIFont {
        return DefaultFont.body.uiFont
    }

    static var senseCaption: UIFont {
        return DefaultFont.caption.uiFont
    }
}
