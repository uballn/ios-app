//
//  User.swift
//  UBALLN Basketball
//
//  Created by Jeremy Gaston on 5/21/17.
//  Copyright © 2017 UBALLN. All rights reserved.
//

import Foundation
import Firebase

struct User {
    
    var username: String!
    var email: String
    var alias: String
    var gender: String
    var age: String
    var experience: String
    var ageCount: String
    var height: String
    var weight: String
    var played: String
    var img: String
    var uid: String
    var ref: DatabaseReference!
    var key: String = ""
    
    init(snapshot: DataSnapshot) {
        self.username = (snapshot.value as! NSDictionary)["username"] as! String
        self.email = (snapshot.value as! NSDictionary)["email"] as! String
        self.alias = (snapshot.value as! NSDictionary)["alias"] as! String
        self.gender = (snapshot.value as! NSDictionary)["gender"] as! String
        self.age = (snapshot.value as! NSDictionary)["age"] as! String
        self.experience = (snapshot.value as! NSDictionary)["experience"] as! String
        self.ageCount = (snapshot.value as! NSDictionary)["ageCount"] as! String
        self.height = (snapshot.value as! NSDictionary)["height"] as! String
        self.weight = (snapshot.value as! NSDictionary)["weight"] as! String
        self.played = (snapshot.value as! NSDictionary)["played"] as! String
        self.img = (snapshot.value as! NSDictionary)["img"] as! String
        self.uid = (snapshot.value as! NSDictionary)["uid"] as! String
        self.ref = snapshot.ref
        self.key = snapshot.key
    }
    
    init(username: String, email: String, alias: String, gender: String, age: String, experience: String, ageCount: String, height: String, weight: String, played: String, img: String, uid: String) {
        
        self.ref = Database.database().reference()
        self.username = username
        self.email = email
        self.alias = alias
        self.gender = gender
        self.age = age
        self.experience = experience
        self.ageCount = ageCount
        self.height = height
        self.weight = weight
        self.played = played
        self.img = img
        self.uid = uid
        
    }
    
    func toAnyObject() -> [String: Any]{
        
        return
            ["username":username, "email":email, "alias":alias, "gender":gender, "age":age, "experience":experience, "ageCount":ageCount, "height":height, "weight":weight, "played":played, "img":img, "uid":uid]
        
    }
}
