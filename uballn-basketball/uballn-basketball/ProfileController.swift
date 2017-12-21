//
//  ProfileController.swift
//  uballn-basketball
//
//  Created by Jeremy Gaston on 11/22/17.
//  Copyright © 2017 UBALLN. All rights reserved.
//

import UIKit
import Firebase

class ProfileController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Outlets
    @IBOutlet var nicknameField: CustomizableTextfield!
    @IBOutlet var birthdayField: CustomizableTextfield!
    @IBOutlet var lopField: CustomizableTextfield!
    @IBOutlet var genderField: CustomizableTextfield!
    
    // Variables
    var databaseRef: DatabaseReference! {
        
        return Database.database().reference()
    }
    
    var storageRef: StorageReference! {
        
        return Storage.storage().reference()
    }
    
    var gender = ["","male", "female"]
    var experience = ["recreational", "high school", "collegiate", "semi-pro", "professional"]
    var refUser = DatabaseReference()
    var uuid = 0
    
    let birthday = UIDatePicker()
    let picker1 = UIPickerView()
    let picker2 = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imgTitle = UIImage(named: "uballn-logo-sm")
        navigationItem.titleView = UIImageView(image: imgTitle)

        refUser = Database.database().reference().child("users")
        picker1.delegate = self
        picker1.dataSource = self
        picker2.delegate = self
        picker2.dataSource = self
        
        genderField.inputView = picker1
        lopField.inputView = picker2
        
        createDatePicker()
    }
    
    // Actions
    @IBAction func createProfile(_ sender: Any) {
        guard let alias = nicknameField.text,
            alias != "",
            let gender = genderField.text,
            gender != "",
            let birthday = birthdayField.text,
            birthday != "",
            let play = lopField.text,
            play != ""
            else {
                AlertController.showAlert(self, title: "Wait A Minute", message: "Please fill out all fields.")
                return
        }
        addUser()
        
        self.performSegue(withIdentifier: "shareContacts", sender: nil)
    }
    
    // Functions
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countrows : Int = gender.count
        if pickerView == picker1 {
            countrows = self.gender.count
        }
            
        else if pickerView == picker2 {
            countrows = self.experience.count
        }
        
        return countrows
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == picker1 {
            let titleRow = gender[row]
            return titleRow
        }
            
        else if pickerView == picker2 {
            let titleRow = experience[row]
            return titleRow
        }
        
        return ""
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == picker1 {
            self.genderField.text = self.gender[row]
            self.view.endEditing(true)
        }
            
        else if pickerView == picker2 {
            self.lopField.text = self.experience[row]
            self.view.endEditing(true)
        }
    }
    
    func createDatePicker(){
        birthday.datePickerMode = .date
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        birthdayField.inputAccessoryView = toolbar
        
        birthdayField.inputView = birthday
    }
    
    @objc func donePressed(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        birthdayField.text = dateFormatter.string(from: birthday.date)
        self.view.endEditing(true)
    }
    
    func addUser(){
        let userID = Auth.auth().currentUser?.uid
        
        let values = ["alias": nicknameField.text! as String,
                      "gender": genderField.text! as String,
                      "age": birthdayField.text! as String,
                      "played": lopField.text! as String,
                      "uid": (Auth.auth().currentUser?.uid)!,
                      "username": (Auth.auth().currentUser?.displayName!)! as String,
                      "email": (Auth.auth().currentUser?.email!)! as String
        ]
        refUser.child(userID!).setValue(values)
        
    }
}
