//
//  AccountManagerViewModel.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 07/01/2022.
//

import Foundation
import Firebase

class AccountRequest {
    public static let shared = AccountRequest()
    var firRef: DatabaseReference
    private init() {
        self.firRef = BaseRequestModel.shared.firRef.child("Users")
    }
    
    func getAllAccount(
        successBlock: @escaping ([UserInfoObject]) -> Void,
        failBlock: @escaping (_ message: String) -> Void) {
            let request = firRef
                .queryOrdered(byChild: "Users")
            request.observe(.value) { (snapShot) in
                var accounts = [UserInfoObject]()
                for child in snapShot.children {
                    if let snap = child as? DataSnapshot {
                        let key = snap.key
                        if let value = snap.value as? [String:Any],
                           var account = UserInfoObject.init(JSON: value) {
                            account.UID = key
                            accounts.append(account)
                        }
                    }
                }
                guard !accounts.isEmpty else {
                    failBlock("Không tìm thấy dữ liệu")
                    return
                }
                successBlock(accounts)
            }
        }
    
    
    func addAcount(account: UserInfoObject, completionBlock: @escaping (Bool, UserInfoObject?)->Void) {
        var account = account
        let request: DatabaseReference = {
            if account.UID.isEmpty {
                return firRef.childByAutoId()
            } else {
                return firRef.child(account.UID)
            }
        }()
        
        let key = request.key ?? ""
        request.setValue(account.toJSON()) { (err, ref) in
            if err != nil {
                completionBlock(false, nil)
                return
            }
            account.UID = key
            completionBlock(true, account)
        }
    }
    
    func registerNewUserWithMail( userName: String,
                                  email: String,
                                  password: String,
                                  imageUrl: String,
                                  birthDay: String,
                                  phoneNumber: String,
                                  isAdmin: Bool,
                                  gender: String,
                                  completionBlock: @escaping (Bool)->Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, err) in
            if let error = err {
                print(error)
                completionBlock(false)
            }
            // Register Success
            if let userData = user {
                let userInfo = ["email":email,
                                "image_url":imageUrl,
                                "userName":userName,
                                "rank": "brone",
                                "phone_number": phoneNumber,
                                "birthDay":birthDay,
                                "isAdmin":isAdmin,
                                "gender":gender] as [String : Any]
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
    
    func registerNewUserWithMail( userName: String,
                                  email: String,
                                  password: String,
                                  birthDay: String,
                                  phoneNumber: String,
                                  isAdmin: Bool,
                                  gender: String,
                                  completionBlock: @escaping (Bool)->Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, err) in
            if let error = err {
                print(error)
                completionBlock(false)
            }
            // Register Success
            if let userData = user {
                let userInfo = ["email":email,
                                "userName":userName,
                                "rank": "brone",
                                "phone_number": phoneNumber,
                                "birthDay":birthDay,
                                "isAdmin":isAdmin,
                                "gender":gender] as [String : Any]
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
    
}

class AccountManagerViewModel: ObservableObject {
    @Published var accounts: [UserInfoObject] = []
    func getAllAccount() {
        AccountRequest.shared.getAllAccount() { accounts in
            self.accounts = accounts
        } failBlock: { message in
            //
        }
    }
    
    func addAccount( userName: String,
                     email: String,
                     password: String,
                     imageUrl: String,
                     birthDay: String,
                     phoneNumber: String,
                     isAdmin: Bool,
                     gender: String,
                     completionBlock: @escaping (Bool) -> Void){
        var account = UserInfoObject()
        account.userName = userName
        account.email = email
        account.imageUrl = imageUrl
        account.birthDay = birthDay
        account.phone_number = phoneNumber
        account.isAdmin = isAdmin
        account.gender = gender
        AccountRequest.shared.addAcount(account: account, completionBlock: { isSuccess, _ in
            completionBlock(isSuccess)
        })
    }
    
    func signUp(userName: String,
                email: String,
                password: String,
                imageUrl: String,
                birthDay: String,
                phoneNumber: String,
                isAdmin: Bool,
                gender: String,
                completionBlock: @escaping (Bool) -> Void) {
        AccountRequest.shared.registerNewUserWithMail(userName: userName,
                                                      email: email,
                                                      password: password,
                                                      imageUrl: imageUrl,
                                                      birthDay: birthDay,
                                                      phoneNumber: phoneNumber,
                                                      isAdmin: isAdmin,
                                                      gender: gender,
                                                          completionBlock: completionBlock)
    }
    
    func updateAccount( userName: String,
                        UID: String,
                     email: String,
                     imageUrl: String,
                     birthDay: String,
                     phoneNumber: String,
                     isAdmin: Bool,
                     gender: String,
                     completionBlock: @escaping (Bool) -> Void){
        var account = UserInfoObject()
        account.UID = UID
        account.userName = userName
        account.email = email
        account.imageUrl = imageUrl
        account.birthDay = birthDay
        account.phone_number = phoneNumber
        account.isAdmin = isAdmin
        account.gender = gender
        AccountRequest.shared.addAcount(account: account, completionBlock: { isSuccess, _ in
            completionBlock(isSuccess)
        })
    }
}
