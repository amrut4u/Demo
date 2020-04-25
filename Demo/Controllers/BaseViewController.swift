//
//  BaseViewController.swift
//  Demo
//
//  Created by Naina Ghormare on 3/26/20.
//  Copyright © 2020 Naina Ghormare. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class BaseViewController: UIViewController, NVActivityIndicatorViewable {
    
    let animationType   : NVActivityIndicatorType    = NVActivityIndicatorType.ballPulse

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func startNVIndicator(messageText:String) {
        startAnimating(CGSize(width: 50.0, height: 50.0), message: messageText, messageFont: nil, type: self.animationType, color: Colors.loaderColor, padding: 0.0, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: UIColor.lightText)
    }
    
    func stopNVIndicator() {
        stopAnimating()
    }

    func showAlert(with message: String, title : String = Macros.ApplicationName) {
        AlertManager.showOKAlert(withTitle: title, withMessage: message, onViewController: self).view.tintColor = Colors.AppColor
    }
}
