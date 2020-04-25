//
//  CustomButton.swift
//  VideoDating
//
//  Created by Naina Ghormare on 7/24/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CustomButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCornerRadius()
    }
    
    @IBInspectable var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }
    
    @IBInspectable var cornerRadiusValue: CGFloat = 10.0 {
        didSet {
            updateCornerRadius()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1.0 {
        didSet {
            updateCornerRadius()
        }
    }
    
    @IBInspectable var borderColorButton: UIColor? = UIColor.clear {
        didSet {
            updateCornerRadius()
        }
    }
    
    func updateCornerRadius() {
        layer.backgroundColor   = UIColor.orange.cgColor//AppColor.btnBackgroundColor.cgColor
        layer.borderColor       = borderColorButton?.cgColor
        layer.borderWidth       = borderWidth
        layer.cornerRadius      = rounded ? ((frame.size.height) / 2) : cornerRadiusValue
        self.clipsToBounds      = true
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
}

