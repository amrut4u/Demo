//
//  CustomSegmentedControl.swift
//  Demo
//
//  Created by Naina Ghormare on 3/27/20.
//  Copyright © 2020 Naina Ghormare. All rights reserved.
//

import UIKit

class CustomSegmentedControl: UISegmentedControl {
    
    override func layoutSubviews(){
        
        super.layoutSubviews()
        
        //corner radius
        let cornerRadius = bounds.height/2
        let maskedCorners: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        //background
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = maskedCorners
        
        //foreground
        let foregroundIndex = numberOfSegments
     if subviews.indices.contains(foregroundIndex), let foregroundImageView = subviews[foregroundIndex] as? UIImageView
        {
            foregroundImageView.bounds = foregroundImageView.bounds.insetBy(dx: 5, dy: 5)
            foregroundImageView.image = UIImage()
            foregroundImageView.highlightedImage = UIImage()
            foregroundImageView.backgroundColor = UIColor.orange
            foregroundImageView.clipsToBounds = true
           foregroundImageView.layer.masksToBounds = true
            
            foregroundImageView.layer.cornerRadius = 25
            foregroundImageView.layer.maskedCorners = maskedCorners
        }
        
        
    }
}
