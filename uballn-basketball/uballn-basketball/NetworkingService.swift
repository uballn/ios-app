//
//  NetworkingService.swift
//  Prept
//
//  Created by Jeremy Gaston on 10/8/17.
//  Copyright © 2017 Prept Apps, LLC. All rights reserved.
//

import Foundation
import Firebase


struct NetworkingService {
    
    var databaseRef: DatabaseReference! {
        
        return Database.database().reference()
    }
    
    var storageRef: StorageReference! {
        
        return Storage.storage().reference()
    }
    
    func signup(username: String, email: String, alias: String, gender: String, age: String, experience: String, ageCount: String, height: String, weight: String, played: String, password: String, pictureData: Data){
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                print (error.localizedDescription)
            }else {
                
//                self.setUserInfo(user: user, alias: alias, gender: gender, age: age, experience: experience, ageCount: ageCount, height: height, weight: weight, played: played, pictureData: pictureData)
                
            }
        })
        
    }
    
//    func setUserInfo(user: User!, alias: String, gender: String, age: String, experience: String, ageCount: String, height: String, weight: String, played: String, pictureData: Data){
//
//        let profilePicturePath = "profileImage\(user.uid)image.jpg"
//        let profilePictureRef = storageRef.child(profilePicturePath)
//        let metaData = StorageMetadata()
//        metaData.contentType = "image/jpeg"
//
//        profilePictureRef.putData(pictureData, metadata: metaData) { (newMetadata, error) in
//            if let error = error {
//                print (error.localizedDescription)
//            }else {
//
//                let changeRequest = user.profileChangeRequest()
//                changeRequest.displayName = "username"
//                if let url = newMetadata?.downloadURL() {
//                    changeRequest.photoURL = url
//                }
//
//                changeRequest.commitChanges(completion: { (error) in
//                    if error == nil {
//
//                        self.saveUserInfoToDB(user: user, alias: alias, gender: gender, age: age, experience: experience, ageCount: ageCount, height: height, weight: weight, played: played)
//
//                    }else {
//                        print(error!.localizedDescription)
//                    }
//                })
//            }
//        }
//
//    }
    
    func fetchAllUsers(completion: @escaping([User])->Void) {
        
        let userRef = databaseRef.child("users")
        userRef.observe(.value, with: { (users) in
            
            var resultArray = [User]()
            for user in users.children {
                let user = User(snapshot: user as! DataSnapshot)
                let currentUser = Auth.auth().currentUser!
                
                if user.uid != currentUser.uid {
                    resultArray.append(user)
                }
                completion(resultArray)
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    private func saveUserInfoToDB(user: User!, alias: String, gender: String, age: String, experience: String, ageCount: String, height: String, weight: String, played: String){
        
        let userRef = databaseRef.child("users").child(user.uid)
        let newUser = User(username: user.username!, email: user.email, alias: alias, gender: gender, age: age, experience: experience, ageCount: ageCount, height: height, weight: weight, played: played, img: String(describing: user.img), uid: user.uid)
        
        userRef.setValue(newUser.toAnyObject()) { (error, ref) in
            if error == nil {
                print("\(user.username!) has been logged in successfully")
            }else {
                print(error!.localizedDescription)
            }
        }
        
    }
    
}
