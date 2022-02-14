//
//  SigupScreen.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 01/01/2022.
//

import SwiftUI
import FirebaseDatabaseSwift

struct SignUpScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel: AccountManagerViewModel = .init()
    @State private var password: String = ""
    @State private var rePassword: String = ""
    @State private var isShowAlert: Bool = false
    @State private var alertMessage: String = ""
    @State var email: String = ""
    @State var name: String = ""
    @State var imageUrl: String = ""
    @State var birthday: String = ""
    @State var phone: String = ""
    @State var isAdmin = false
    @State var listgender : [String] = ["Male","Female"]
    @State var gender : String = ""
    // MARK: - Public
    var onSignUpSuccess: ()-> Void
    // MARK: - Body
    var body: some View {
        VStack {
                Group{
                    TextField("Email", text: $email)
                        .padding(.horizontal, 16)
                        .height(40)
                        .gradientBorder()
                        .padding(.horizontal, 32)
                    SecureField("Password", text: $password)
                        .padding(.horizontal, 16)
                        .height(40)
                        .gradientBorder()
                        .padding(.horizontal, 32)
                    SecureField("Repassword", text: $rePassword)
                        .padding(.horizontal, 16)
                        .height(40)
                        .gradientBorder()
                        .padding(.horizontal, 32)
                    TextField("Name", text: $name)
                        .padding(.horizontal, 16)
                        .height(40)
                        .gradientBorder()
                        .padding(.horizontal, 32)
                    HStack{
                        Text("Gender")
                            .font(.system(size: 17).weight(.medium))
                            .expandedWidth(alignment: .leading)
                            .padding(.leading, 32)
                        Picker(selection: $gender, label:
                                Text("Gender")){
                            ForEach(listgender.indices, id: \.self){ index in
                                Text(listgender[index]).tag(listgender[index])
                            }
                        }.padding(.trailing, 32)
                    }
                    TextField("Birth Day", text: $birthday)
                        .padding(.horizontal, 16)
                        .height(40)
                        .gradientBorder()
                        .padding(.horizontal, 32)
                    TextField("Phone Number", text: $phone)
                        .padding(.horizontal, 16)
                        .height(40)
                        .gradientBorder()
                        .padding(.horizontal, 32)
                }
                Spacer()
                Button {
                        signUp()
                } label: {
                    Text("Sign Up")
                        .foregroundColor(.white)
                        .height(50)
                        .expandedWidth()
                        .gradientBackgound()
                        .padding(.horizontal, 16)
                }
            
        }.addNavigationBar(title: "Đăng ký",isHiddenCart: true)
        .alert("Thông báo", isPresented: $isShowAlert) {
            Button {
                isShowAlert = false
            } label: {
                Text("Đồng ý")
            }
        } message: {
            Text(alertMessage)
        }
        .modifier(HideNavModifier())
        
    }
    // MARK: - Func
    func signUp() {
        guard !email.isEmpty, !password.isEmpty, !rePassword.isEmpty, !phone.isEmpty, !birthday.isEmpty else {
            alertMessage = "Bạn phải nhập đầy đủ thông tin"
            isShowAlert = true
            return
        }
        guard password == rePassword else {
            alertMessage = "Mật khẩu không khớp"
            isShowAlert = true
            return
        }
        viewModel.signUp(userName: name,
                         email: email,
                         password: password,
                         imageUrl: "",
                         birthDay: birthday,
                         phoneNumber: phone,
                         isAdmin: isAdmin,
                         gender: gender) { isSuccess in
            if isSuccess {
                presentationMode.wrappedValue.dismiss()
                onSignUpSuccess()
            }
        }
    }
    
 
}

struct SigupScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreen(){}
    }
}
