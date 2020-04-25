//
//  BankDetailVC.swift
//  Demo
//
//  Created by Naina Ghormare on 3/26/20.
//  Copyright © 2020 Naina Ghormare. All rights reserved.
//

import UIKit

class BankDetailVC: BaseViewController {
    
    @IBOutlet weak var tblBankDetail: UITableView!
    
    var placeholderArr = [("user", "Account Holder Name"), ("user", "Bank Name"), ("user", "Branch Code"), ("user", "SWIFT /BIC Code"), ("user", "Account Number"), ("user", "Branch/Bank Address"), ("user", "IBAN")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func gotoBankDetail(_ sender: UIButton) {
        let controller = self.storyboard?.instantiateViewController(identifier: "DetailsVC") as! DetailsVC
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension BankDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeholderArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BankDetailCell", for: indexPath) as! BankDetailCell
        cell.txtField.placeholder = placeholderArr[indexPath.row].1
        cell.txtField.title = placeholderArr[indexPath.row].1
        return cell
    }

}

class BankDetailCell: UITableViewCell {
    @IBOutlet weak var txtField: CustomTextField!
}
