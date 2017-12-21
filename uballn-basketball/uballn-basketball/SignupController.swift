//
//  SignupController.swift
//  uballn-basketball
//
//  Created by Jeremy Gaston on 11/10/17.
//  Copyright © 2017 UBALLN. All rights reserved.
//

import UIKit
import Firebase

class SignupController: UIViewController {
    
    var refUser = DatabaseReference()
    
    @IBOutlet var nameField: CustomizableTextfield!
    @IBOutlet var emailField: CustomizableTextfield!
    @IBOutlet var usernameField: CustomizableTextfield!
    @IBOutlet var passwordField: CustomizableTextfield!
    @IBOutlet var showClick: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imgTitle = UIImage(named: "uballn-logo-sm")
        navigationItem.titleView = UIImageView(image: imgTitle)
        
    }

    @IBAction func backButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwindSegueToLanding", sender: self)
    }
    
    @IBAction func signupFB(_ sender: Any) {
    }
    
    @IBAction func signupTW(_ sender: Any) {
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
    
    @IBAction func submit(_ sender: Any) {
        guard let name = nameField.text,
            name != "",
            let email = emailField.text,
            email != "",
            let username = usernameField.text,
            username != "",
            let password = passwordField.text,
            password != ""
            else {
                AlertController.showAlert(self, title: "Forget Something?", message: "Please fill out all fields.")
                return
        }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            guard error == nil else {
                AlertController.showAlert(self, title: "Error", message: error!.localizedDescription)
                return
            }
            guard let user = user else {
                return
            }
            print(user.email ?? "MISSING EMAIL")
            print(user.uid)
            
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = name
            changeRequest.commitChanges(completion: { (error) in
                guard error == nil else {
                    AlertController.showAlert(self, title: "Error", message: error!.localizedDescription)
                    return
                }
                self.performSegue(withIdentifier: "profileDetails", sender: nil)
            })
        })
    }
    
}
