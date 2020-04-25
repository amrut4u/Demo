//
//  CustomErrorTextField.swift
//  VideoDating
//
//  Created by Naina Ghormare on 7/26/19.
//  Copyright © 2019 smartData Enterprizes. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class CustomTextField: SkyFloatingLabelTextFieldWithIcon {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        self.lineColor          = .white//AppColor.textFieldColor
        self.placeholderColor   = .white//AppColor.textFieldColor
        self.textColor          = .white
        self.selectedLineColor  = UIColor.init("#217FE5")
        self.selectedTitleColor = UIColor.init("#217FE5")//AppColor.textFieldColor
        self.iconType           = .image
        self.iconMarginLeft     = 11
        self.iconMarginBottom   = 2
        self.font               = UIFont.systemFont(ofSize: 17)
    }
    
}

