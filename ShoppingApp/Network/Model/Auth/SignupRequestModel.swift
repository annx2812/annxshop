//
//  TardisSignupRequestModel.swift
//  FireBase001
//
//  Created by Hoang on 6/3/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import Firebase

class SignupRequestModel {
    static let shared = SignupRequestModel()
    
    var firRef: DatabaseReference
    private init() {
        self.firRef = BaseRequestModel.shared.firRef.child("Users")
    }
    
    func registerNewUserWithMail( userName: String,
                                  password: String,
                                  phoneNumber: String,
                                  completionBlock: @escaping (Bool)->Void) {
        Auth.auth().createUser(withEmail: userName, password: password) { (user, err) in
            if let error = err {
                print(error)
                completionBlock(false)
            }
            // Register Success
            if let userData = user {
                let userInfo = ["email":userName,
                                "image_url":baseImageUrl,
                                "displayName":userName,
                                "rank": "brone",
                                "phone_number": phoneNumber]
                let userRef = self.firRef.child(userData.user.uid)
                userRef.setValue(userInfo) { (err, firRef) in
                    if let error = err {
                        print(error.localizedDescription)
                        completionBlock(false)
                    }
                    
                    LoginRequestModel.shared.login(username: userName, password: password) { (status) in
                        completionBlock(true)
                    }
                    
                }
            }
            
        }
    }
    
    func updateUser(userInfo: Dictionary<String,Any>,completionBlock: @escaping (Bool)->Void) {
        firRef.updateChildValues(userInfo) { (err, ref) in
            if let errMess = err {
                print(errMess)
                return
            }
        }
    }
}
