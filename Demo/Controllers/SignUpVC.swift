//
//  SignUpVC.swift
//  Demo
//
//  Created by Naina Ghormare on 3/26/20.
//  Copyright © 2020 Naina Ghormare. All rights reserved.
//

import UIKit
enum UserReg:Int {
        case name   =   0
        case email
        case mobile
        case phoneNo
        case country
        case password
        case confirmPassword
}
enum UserRegTag {
    static let name = 100
    static let email = 200
    static let mobile = 300
    static let phoneNo = 400
    static let country = 500
    static let password = 600
    static let confirmPassword = 700
}


class SignUpVC: BaseViewController {
    
    @IBOutlet weak var tblRegiter       : UITableView!
    @IBOutlet weak var segmentControl   : CustomSegmentedControl!
    var user = User()
    var newUserArr = [("user", "Full Name"), ("mail", "Email Address"), ("phone", "Mobile Number"), ("phone", "Secondary Phone Number"), ("location", "Country"), ("key", "Password"), ("key", "Confirm Password"),("","")]
    var companyArr = [("user", "Full Name"), ("user", "Company Name"), ("location", "Company Address"), ("location", "Country"), ("phone", "Primary Contact Number"), ("phone", "Primary Mobile Number"), ("mail", "Company Email Address"), ("user", "Company Founder Details"), ("user", "Id/Pass/Driver Licence"), ("phone", "Secondary Phone Number"), ("attachment", "Company Registration Documents"), ("key", "Password"), ("key", "Confirm Password"),("","")]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
    @IBAction func gotoBankDetail(_ sender: UIButton) {
        let service = UserService()
        service.userRegister(with: user, target: self) { (result) in
            let controller = self.storyboard?.instantiateViewController(identifier: "BankDetailVC") as! BankDetailVC
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    @IBAction func gotoLogin(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func userTypChanged(_ sender: UISegmentedControl) {
        self.segmentControl.selectedSegmentIndex = sender.selectedSegmentIndex
        self.tblRegiter.reloadData()
    }
    
    @objc func actionTermsCondition(_ sender: UIButton){
        sender.isSelected = !sender.isSelected
    }
}

extension SignUpVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.segmentControl.selectedSegmentIndex == 0 ? newUserArr.count : companyArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.segmentControl.selectedSegmentIndex == 0 {
            return indexPath.row == (newUserArr.count - 1) ? customTermsConditionCell(tableView, indexPath: indexPath) : customUserRegCell(tableView: tableView, indexPath: indexPath)
        }
        return indexPath.row == (companyArr.count - 1) ? customTermsConditionCell(tableView, indexPath: indexPath) : customBankRegistrationCell(tableView: tableView, indexPath: indexPath)
        
    }
    
    func customBankRegistrationCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegistrationOne", for: indexPath) as! RegistrationOne
        let userInfo = self.segmentControl.selectedSegmentIndex == 0 ? newUserArr : companyArr
        cell.txtField.iconImage = UIImage(named: userInfo[indexPath.row].0)
        cell.txtField.placeholder = userInfo[indexPath.row].1
        cell.txtField.title = userInfo[indexPath.row].1
        cell.txtField.text = cell.txtField.iconImage == UIImage(named: "phone") ? "+91" : ""
        return cell
    }

    func customUserRegCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegistrationOne", for: indexPath) as! RegistrationOne
        cell.txtField.delegate = self
        cell.txtField.isSecureTextEntry = (UserReg.init(rawValue: indexPath.row) == .password || UserReg.init(rawValue: indexPath.row) == .confirmPassword)
        let userInfo = self.segmentControl.selectedSegmentIndex == 0 ? newUserArr : companyArr
        cell.txtField.iconImage = UIImage(named: userInfo[indexPath.row].0)
        cell.txtField.placeholder = userInfo[indexPath.row].1
        cell.txtField.title = userInfo[indexPath.row].1
        cell.txtField.text = cell.txtField.iconImage == UIImage(named: "phone") ? "+91" : ""
        switch UserReg.init(rawValue: indexPath.row){
        case .name :
            cell.txtField.keyboardType = .default
            cell.txtField.tag = UserRegTag.name
        case .email :
            cell.txtField.keyboardType = .emailAddress
            cell.txtField.tag = UserRegTag.email
        case .mobile :
            cell.txtField.keyboardType = .phonePad
            cell.txtField.tag = UserRegTag.mobile
        case .phoneNo :
            cell.txtField.keyboardType = .phonePad
            cell.txtField.tag = UserRegTag.phoneNo
        case .country :
            cell.txtField.keyboardType = .default
            cell.txtField.tag = UserRegTag.country
        case .password :
            cell.txtField.keyboardType = .default
            cell.txtField.tag = UserRegTag.password
        case .confirmPassword :
            cell.txtField.keyboardType = .default
            cell.txtField.tag = UserRegTag.confirmPassword
        default :
            break
        }
        return cell
    }
    
    func customTermsConditionCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TermsAndCondtionButtonCell") as! TermsAndCondtionButtonCell
        cell.btnTerms.addTarget(self, action: #selector(actionTermsCondition(_:)), for: .touchUpInside)
        return cell
        
    }
    
}

//MARK:- UITextFieldDelegate
extension SignUpVC: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString:NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        if self.segmentControl.selectedSegmentIndex == 0 {
            switch textField.tag {
            case UserRegTag.name :
                user.name = newString as String
            case UserRegTag.email:
                user.email = newString as String
            case UserRegTag.mobile:
                user.mobile_no = newString as String
            case UserRegTag.phoneNo:
                user.second_mobile_no = newString as String
            case UserRegTag.country:
                user.country = newString as String
            case UserRegTag.password:
                user.password = newString as String
            case UserRegTag.confirmPassword:
                user.confirmPassword = newString as String
            default:
                return true
            }
        }
        return true
    }
}

//MARK:- UITableView Cell
class RegistrationOne: UITableViewCell {
    @IBOutlet weak var txtField: CustomTextField!
}

class TermsAndCondtionButtonCell: UITableViewCell {
    @IBOutlet weak var btnTerms: UIButton!
}
