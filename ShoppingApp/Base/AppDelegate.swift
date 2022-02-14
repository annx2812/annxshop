//
//  AppDelegate.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 30/12/2021.
//

import Foundation
import SwiftUI
import UIKit
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
//        BaseRequestModel.shared.doLogOut()
        if UserInfo.shared.userDidLogin() {
            BaseRequestModel.shared.getCurrentUserInfo()
            BaseRequestModel.shared.updateUserLoginStatus(true)
        }
        return true
    }
}
