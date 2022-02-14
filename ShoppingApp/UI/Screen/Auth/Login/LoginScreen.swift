//
//  LoginScreen.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 30/12/2021.
//

import SwiftUI

struct LoginScreen: View {
    @State private var isShowAlert: Bool = false
    @State private var alertMessage: String = ""
    
    @StateObject private var viewModel: LoginScreenViewModel = .init()
    @State private var userName: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack {
            Image("ic_cart")
                .resizable()
                .renderingMode(.template)
                .frame(width: 60, height: 60)
                .frame(width: 100, height: 100)
                .gradientBackgound()
                .clipShape(Curve())
            
                .foregroundColor(.white)
            Spacer().height(100)
            TextField("Tên đăng nhập", text: $userName)
                .padding(.horizontal, 16)
                .height(40)
                .gradientBorder()
                .padding(.horizontal, 32)
            SecureField("Mật khẩu", text: $password)
                .padding(.horizontal, 16)
                .height(40)
                .gradientBorder()
                .padding(.horizontal, 32)
            Spacer().height(40)
            Button {
                signIn()
            } label: {
                Text("Đăng nhập")
                    .foregroundColor(.white)
                    .expandedWidth()
                    .height(40)
                    .gradientBackgound()
                    .padding(.horizontal, 32)
            }
            
            NavigationLink {
                SignUpScreen() {
                    alertMessage = "Đăng ký thành công"
                    isShowAlert = true
                }
            } label: {
                Text("Đăng ký")
                    .expandedWidth()
                    .height(40)
                    .gradientBorder()
                    .padding(.horizontal, 32)
            }
        }.addNavigationBar(title: "Đăng nhập", isHiddenBackButton: true, isHiddenCart: true)
            .alert("Thông báo", isPresented: $isShowAlert) {
                Button {
                    isShowAlert = false
                } label: {
                    Text("Đồng ý")
                }
            } message: {
                Text(alertMessage)
            }
    }
    // MARK: - Func
    func signIn() {
        viewModel.doLogin(userName: userName, password: password) { isSuccess in
            if isSuccess {
                
            }
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
