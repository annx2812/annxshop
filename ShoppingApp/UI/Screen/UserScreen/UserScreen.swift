//
//  UserScreen.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 30/12/2021.
//

import SwiftUI

struct UserScreen: View {
    @ObservedObject var userInfo = UserInfo.shared
    var body: some View {
        VStack {
            if let currentUser = userInfo.currentUser {
                if currentUser.isAdmin == true{
                    ManagerScreen(userInfo: currentUser)
                }
                else {
                    UserDetail(userInfo: currentUser)
                }
            } else {
                LoginScreen()
            }
            Spacer()
        }
    }
}

struct UserScreen_Previews: PreviewProvider {
    static var previews: some View {
        UserScreen()
    }
}
