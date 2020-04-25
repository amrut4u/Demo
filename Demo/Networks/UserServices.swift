//
//  UserServices.swift
//  Demo
//
//  Created by Naina Ghormare on 4/20/20.
//  Copyright © 2020 Naina Ghormare. All rights reserved.
//

import Foundation
import UIKit

public class UserService: APIService {
    
    //MARK:-Login Api Method:--
    func doLogin(with email: String, password:String, target: BaseViewController? = nil, complition: @escaping (User?) -> Void){
        let param = [Macros.DefaultKeys.kEmail: email, Macros.DefaultKeys.kPassword: password]
        print(param)
        target?.startNVIndicator(messageText: "")
        super.startService(with: .POST, path: Config.ServiceName.login, parameters: param, target: target!, files: []) { (result) in
            DispatchQueue.main.async {
                target?.stopNVIndicator()
                switch result {
                case .Success(let response):
                    // #parse response here
                    if let data = ((response as? Dictionary<String,Any>)?["data"] as? Dictionary<String,Any>) {
                        let user = User(dictionary: data)
                        complition(user)
                    } else {
                        complition(nil)
                    }
                case .Error(let error):
                    // #display error message here
                    target?.showAlert(with: error)
                    complition(nil)
                }
            }
        }
    }
    
    func userRegister(with user: User, target: BaseViewController? = nil, complition: @escaping (Any?) -> Void){
        let param = [APIKeys.address : user.address ?? "", APIKeys.country : user.country ?? "", APIKeys.email : user.email ?? "", APIKeys.mobile_no : user.mobile_no ?? "", APIKeys.name : user.name ?? "", APIKeys.password : user.password ?? "", APIKeys.second_mobile_no : user.second_mobile_no ?? ""]
        print(param)
        target?.startNVIndicator(messageText: "")
        super.startService(with: .POST, path: Config.ServiceName.userReg, parameters: param, target: target!, files: []) { (result) in
            DispatchQueue.main.async {
                target?.stopNVIndicator()
                switch result {
                case .Success(let response):
                    // #parse response here
                    if let data = ((response as? Dictionary<String,Any>)?["data"] as? Dictionary<String,Any>) {
                        let user = User(dictionary: data)
                        complition(user)
                    } else {
                        complition(nil)
                    }
                case .Error(let error):
                    // #display error message here
                    target?.showAlert(with: error)
                    complition(nil)
                }
            }
        }
    }
    
    
}
