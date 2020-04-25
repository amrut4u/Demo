//
//  DetailsVC.swift
//  Demo
//
//  Created by Naina Ghormare on 3/26/20.
//  Copyright © 2020 Naina Ghormare. All rights reserved.
//

import UIKit

class DetailsVC: BaseViewController {
    
    @IBOutlet weak var tblDetail: UITableView!
    
    var placeholderArr = [("user", "Geolocation"), ("user", "Device ID"), ("user", "Top 10 Called List"), ("user", "IP")]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func gotoOtherDetail(_ sender: UIButton) {
        let controller = self.storyboard?.instantiateViewController(identifier: "OtherDetailVC") as! OtherDetailVC
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
extension DetailsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell", for: indexPath) as! DetailsCell
        cell.txtField.placeholder = placeholderArr[indexPath.row].1
        cell.txtField.title = placeholderArr[indexPath.row].1
        return cell
    }

}

class DetailsCell: UITableViewCell {
    @IBOutlet weak var txtField: CustomTextField!
}
