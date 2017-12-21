//
//  LoginController.swift
//  uballn-basketball
//
//  Created by Jeremy Gaston on 11/10/17.
//  Copyright © 2017 UBALLN. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginController: UIViewController {
    
    //Outlet
    @IBOutlet var emailField: CustomizableTextfield!
    @IBOutlet var passwordField: CustomizableTextfield!
    @IBOutlet var showClick: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let imgTitle = UIImage(named: "uballn-logo-sm")
        navigationItem.titleView = UIImageView(image: imgTitle)
        
    }

    @IBAction func backButton(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindSegueToLanding", sender: self)
    }
    
    @IBAction func revealPassword(_ sender: Any) {
        if passwordField.isSecureTextEntry {
            passwordField.isSecureTextEntry = false
            showClick.isSelected = true
        } else {
            passwordField.isSecureTextEntry = true
            showClick.isSelected = false
        }
    }
    
}
