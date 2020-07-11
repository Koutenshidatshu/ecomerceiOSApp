//
//  LoginViewController.swift
//  ecomerce-iOS
//
//  Created by Yonathan Wijaya on 11/07/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var checkbox: UIButton!
    private var isRememberMe = false
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func rememberMeTapped(_ sender: Any) {
        isRememberMe = !isRememberMe
        if isRememberMe {
            checked()
        } else {
            unchecked()
        }
    }
    

    private func unchecked() {
        checkbox.setImage(UIImage(named: "unchecked"), for: .normal)
    }
    
    private func checked() {
        checkbox.setImage(UIImage(named: "checked"), for: .normal)
    }
    
    
}
