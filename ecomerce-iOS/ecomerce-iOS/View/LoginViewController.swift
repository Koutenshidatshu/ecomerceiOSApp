//
//  LoginViewController.swift
//  ecomerce-iOS
//
//  Created by Yonathan Wijaya on 11/07/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import UIKit
import Foundation

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
    
    @IBAction func signInTapped(_ sender: Any) {
        goToHomePage()
    }
    
    private func unchecked() {
        checkbox.setImage(UIImage(named: "unchecked"), for: .normal)
    }
    
    private func checked() {
        checkbox.setImage(UIImage(named: "checked"), for: .normal)
    }
    
    func goToHomePage() {
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TabBarViewController")
        
        // Set the new rootViewController of the window.
        // Calling "UIView.transition" below will animate the swap.
        keyWindow?.rootViewController = vc
    }
}
