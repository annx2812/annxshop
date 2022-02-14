//
//  SignUpViewModel.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 01/01/2022.
//

import Foundation

class SignUpViewModel: ObservableObject {
    func signUp(userName: String, password: String, phoneNumber: String, completionBlock: @escaping (Bool) -> Void) {
        SignupRequestModel.shared.registerNewUserWithMail(userName: userName,
                                                          password: password,
                                                          phoneNumber: phoneNumber,
                                                          completionBlock: completionBlock)
    }
}
