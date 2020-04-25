//
//  Constants.swift
//  Demo
//
//  Created by Naina Ghormare on 4/20/20.
//  Copyright © 2020 Naina Ghormare. All rights reserved.
//

import Foundation
import UIKit

enum Macros {
    static let ApplicationName = "Pay Me Safe"
    struct DefaultKeys {
        static let kEmail = "email"
        static let kPassword = "password"
    }
}

enum Colors {
    static let AppColor = UIColor("#3F1473")
    static let loaderColor = UIColor("#8629F9")
}

enum Config {
    
    static let baseUrl                          = "http://dssolution.in/demo/paymesafe/api/" //live
    
    static let imgUrl                           = "http://phm.iotied.com/public/" // live
    
    static let activityImg                      = "assets/uploads/activityImage/"
    static let signImg                          = "assets/uploads/signatureImg/"
    
    struct ServiceName {
        static let login                   = "login"
        static let userReg                 = "user-registration"
    }
}

enum APIKeys {
    static let name             = "name"
    static let country          = "country"
    static let mobile_no        = "mobile_no"
    static let email            = "email"
    static let second_mobile_no = "second_mobile_no"
    static let address          = "address"
    static let password         = "password"
    
    
    
}
