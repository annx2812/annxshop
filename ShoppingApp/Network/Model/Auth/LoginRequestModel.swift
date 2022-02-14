//
//  TardisLoginRequestModel.swift
//  FireBase001
//
//  Created by Hoang on 5/11/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import Firebase

class LoginRequestModel {
    static let shared = LoginRequestModel()
    
    var firRef: DatabaseReference
    init() {
        self.firRef = BaseRequestModel.shared.firRef.child("users")
    }
    
    func login(username: String, password: String, completionBlock: ((Bool) -> Void)?) {
        Auth.auth().signIn(withEmail: username, password: password) { (user, error) in
            if let err = error {
                print(err)
                print(err.localizedDescription)
                if let completionBlock = completionBlock {completionBlock(false)}
                return
            }
            BaseRequestModel.shared.getCurrentUserInfo()
            BaseRequestModel.shared.updateUserLoginStatus(true)
            if let completionBlock = completionBlock {completionBlock(true)}
        }
    }
}
