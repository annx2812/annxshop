//
//  TardisBaseRequestModel.swift
//  FireBase001
//
//  Created by Hoang on 6/19/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import Firebase
import ObjectMapper

class BaseRequestModel: NSObject {
    let baseUrl = "https://shoppingapp-67716-default-rtdb.firebaseio.com/"
    static let shared = BaseRequestModel()
    var firRef: DatabaseReference
    var firStorageRef: StorageReference
    let auth: Auth
    let storage: Storage
    override init() {
        firRef = Database.database().reference(fromURL: baseUrl)
        firStorageRef = Storage.storage().reference()
        self.auth = Auth.auth()
        self.storage = Storage.storage()
    }
    
    func getCurrentUserInfo() {
        firRef.child("Users").child(UserInfo.shared.getUID()).observeSingleEvent(of: .value) { (data) in
            if let dataValue = data.value as? [String : AnyObject]{
                UserInfo.shared.currentUser = UserInfoObject.init(JSON: dataValue)!
            }
        }
    }
    func getUser(UID: String, completionBlock: @escaping(Bool, UserInfoObject) -> Void) {
        if UID.count == 0 {
            print("Fail Herre")
            completionBlock(false, UserInfoObject())
            return
        }
        firRef.child("Users").child(UID).observeSingleEvent(of: .value) { (data) in
            if let dataValue = data.value as? [String : AnyObject]{
                if var user = UserInfoObject.init(JSON: dataValue) {
                    user.UID = UID
                    completionBlock(true, user)
                } else {
                    completionBlock(false, UserInfoObject())
                }
            }
        }
    }
    
    func doLogOut() {
        updateLoginTime()
        updateUserLoginStatus(false)
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
            return
        }
        UserInfo.shared.resetData()
    }
    
    func removeAllObserver() {
        firRef.removeAllObservers()
    }
    
    func getStringFromPath(_ path: String, completionBlock: @escaping (String) -> Void) {
        firRef.child(path).observeSingleEvent(of: .value) { (snapShot) in
            guard let value = snapShot.value as? String else {
                completionBlock("")
                return
            }
            completionBlock(value)
        }
    }
    func observeAllOtherUsers(completionBlock: @escaping (Bool,[UserInfoObject]) -> Void) {
        firRef.child("Users").observe(.value) { (snapShot) in
            var arrayActivities = [UserInfoObject]()
            for child in snapShot.children {
                guard let snap = child as? DataSnapshot else {
                    completionBlock(false,[])
                    return
                }
                let key = snap.key
                if key == UserInfo.shared.getUID() {
                    continue
                }
                guard let value = snap.value as? [String:Any] else {
                    completionBlock(false,[])
                    return
                }
                guard var activity = UserInfoObject.init(JSON: value) else {
                    completionBlock(false,[])
                    return
                }
                activity.UID = key
                arrayActivities.append(activity)
            }
            completionBlock(true,arrayActivities)
        }
    }
    
    func getListALLOtherUser(completionBlock: @escaping (Bool,[UserInfoObject]) -> Void) {
        firRef.child("Users").observeSingleEvent(of: .value) { (snapShot) in
            var arrayActivities = [UserInfoObject]()
            for child in snapShot.children {
                guard let snap = child as? DataSnapshot else {
                    completionBlock(false,[])
                    return
                }
                let key = snap.key
                if key == UserInfo.shared.getUID() {
                    continue
                }
                guard let value = snap.value as? [String:Any] else {
                    completionBlock(false,[])
                    return
                }
                guard var activity = UserInfoObject.init(JSON: value) else {
                    completionBlock(false,[])
                    return
                }
                activity.UID = key
                arrayActivities.append(activity)
            }
            completionBlock(true,arrayActivities)
        }
    }
    func updateUserLoginStatus(_ status: Bool) {
        firRef.child("Users").child(UserInfo.shared.getUID()).child("is_login").setValue(status)
    }
    func updateLoginTime() {
        firRef.child("Users").child(UserInfo.shared.getUID()).child("last_online").setValue(Date().timeIntervalSince1970)
        
    }
    func getAllData<T:BaseMapObject>(fromPath path: String, completionBlock: @escaping (Bool,[T]) -> Void) {
        firRef.child(path).observe(.value) { (snapShot) in
            var listResult = [T]()
            for child in snapShot.children {
                guard let snap = child as? DataSnapshot else {
                    completionBlock(false,[])
                    return
                }
                let key = snap.key
                guard let value = snap.value as? [String:Any] else {
                    completionBlock(false,[])
                    return
                }
                guard var object = T.init(JSON: value) else {
                    completionBlock(false,[])
                    return
                }
                
                object.id = key
                listResult.append(object)
            }
            completionBlock(true,listResult)
        }
    }
    
}
