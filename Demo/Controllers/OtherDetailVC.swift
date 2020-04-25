//
//  OtherDetailVC.swift
//  Demo
//
//  Created by Naina Ghormare on 3/26/20.
//  Copyright © 2020 Naina Ghormare. All rights reserved.
//

import UIKit

class OtherDetailVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func  popToLogin(_ sender: UIButton) {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: LoginVC.self) {
                _ =  self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
        
    }
    
}
