//
//  UserInfo.swift
//  FireBase001
//
//  Created by Hoang on 6/3/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import Firebase
class UserInfo: ObservableObject {
    public static var shared = UserInfo()
    private init() {}
    func resetData() {
        currentUser = nil
        objectWillChange.send()
    }
    @Published var currentUser: UserInfoObject?
    
    
    // MARK: - UID
    func getUID() -> String {
        return Auth.auth().currentUser?.uid ?? ""
    }
    // MARK: - Login
    func setLogin() {
        UserDefaults.standard.set(true, forKey: "IS_LOGIN")
        UserDefaults.standard.synchronize()
    }
    
    func getLogin() -> Bool{
        return UserDefaults.standard.bool(forKey: "IS_LOGIN")
    }
    // MARK: - Username
    func setUsername() {
        UserDefaults.standard.set(true, forKey: "USERNAME")
        UserDefaults.standard.synchronize()
    }
    
    func getUsername() -> String{
        return UserDefaults.standard.string(forKey: "USERNAME") ?? ""
    }
    // MARK: - Password
    func setPassword() {
        UserDefaults.standard.set(true, forKey: "PASSWORD")
        UserDefaults.standard.synchronize()
    }
    
    func getPassword() -> String{
        return UserDefaults.standard.string(forKey: "PASSWORD") ?? ""
    }
    // MARK: - DidLogin
    func userDidLogin() -> Bool{
        if Auth.auth().currentUser != nil {
            return true
        } else {
            return false
        }
    }
    // MARK: - UserInfo
    static func getUserInfo() -> User? {
        if let user = Auth.auth().currentUser {
            return user
        } else {
            return nil
        }
    }
}
