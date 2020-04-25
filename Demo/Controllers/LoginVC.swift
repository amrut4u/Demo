//
//  ViewController.swift
//  Demo
//
//  Created by Naina Ghormare on 3/25/20.
//  Copyright © 2020 Naina Ghormare. All rights reserved.
//

import UIKit

class LoginVC: BaseViewController {

    @IBOutlet weak var txtFieldEmail: CustomTextField!
    @IBOutlet weak var txtFieldPassword: CustomTextField!
    @IBOutlet weak var eyePassword      : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func SignUp(_ sender: UIButton) {
        let controller = self.storyboard?.instantiateViewController(identifier: "SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func LoginAction(_ sender: UIButton) {
        validationCheck()
    }
    
    func validationCheck() {
        if let email = self.txtFieldEmail.text, email.isEmpty {
            self.showAlert(with: "Please enter email address.")
        } else if !(isValidEmail(testStr: self.txtFieldEmail.text ?? "")) {
            self.showAlert(with: "Please enter valid email address.")
        } else if let pwd = self.txtFieldPassword.text, pwd.isEmpty {
            self.showAlert(with: "Please enter password.")
        } else if !(isValidPwd(testStr: self.txtFieldPassword.text ?? "")) {
            self.showAlert(with: "Password should contain combination of upper and lower case letters, digits and one special character. It should be of 8-16 characters.")
        } else {
            self.login()
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func isValidPwd(testStr:String) -> Bool {
        let emailRegEx = "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{8,20}$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }

    
    func login() {
        let service = UserService()
        service.doLogin(with: self.txtFieldEmail.text ?? "", password: self.txtFieldPassword.text ?? "", target: self, complition: { (response) in
            DispatchQueue.main.async {
                if let user = response {
                   // AppInstance.shared.user = user
                   // AppInstance.shared.kUserDefault.setValue(AppInstance.shared.user?.dictionaryRepresentation(), forKey: Macros.userDetails)
                    let controller = self.storyboard?.instantiateViewController(identifier: "SignUpVC") as! SignUpVC
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            }
        })
        
        

    }
    
    @IBAction func eyePassword(_ sender: UIButton) {
        if txtFieldPassword.isSecureTextEntry {
            let image = UIImage(named: "hidePwd")
            eyePassword.setImage(image, for: .normal)
            txtFieldPassword.isSecureTextEntry = false
        } else {
            let image = UIImage(named: "showPwd")
            eyePassword.setImage(image, for: .normal)
            txtFieldPassword.isSecureTextEntry = true
        }
    }

}

