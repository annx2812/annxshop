//
//  LoginScreenViewModel.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 01/01/2022.
//

import Foundation

class LoginScreenViewModel: ObservableObject {
    func doLogin(userName: String, password: String, completionBlock: @escaping (Bool) -> Void) {
        LoginRequestModel.shared.login(username: userName, password: password, completionBlock: completionBlock)
    }
}
