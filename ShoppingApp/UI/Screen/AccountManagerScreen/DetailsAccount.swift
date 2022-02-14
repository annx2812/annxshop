//
//  DetailsAccount.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 11/01/2022.
//

import SwiftUI
import SDWebImageSwiftUI
struct DetailsAccount: View {
    @StateObject var viewModel: AccountManagerViewModel = .init()
    @State var account : UserInfoObject
    @State var showSheet: Bool = false
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Ảnh cá nhân:")
                .font(.system(size: 14).weight(.medium))
                .padding(.leading, 16)
            if account.imageUrl == ""{
                Image("ic_user")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .expandedWidth()
                    .gradientBackgound()
                    .clipShape(Circle())
            }else{
                WebImage(url: URL(string: account.imageUrl ?? ""))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
                    .clipShape(Curve())
                    .expandedWidth()
            }
            VStack(alignment: .leading, spacing: 10){
                Group {
                    Text("Email:")
                        .font(.system(size: 14).weight(.medium))
                        .padding(.top, 10)
                    Text(account.email ?? "")
                        .font(.system(size: 18).weight(.medium))
                        .expandedWidth()
                    Text("Tên người dùng:")
                        .font(.system(size: 14).weight(.medium))
                    Text(account.userName ?? "")
                        .font(.system(size: 18).weight(.medium))
                        .expandedWidth()
                    Text("Giới tính:")
                        .font(.system(size: 14).weight(.medium))
                    Text(account.gender ?? "")
                        .font(.system(size: 18).weight(.medium))
                        .expandedWidth()
                    Text("Ngày sinh:")
                        .font(.system(size: 14).weight(.medium))
                    Text(account.birthDay ?? "")
                        .font(.system(size: 18).weight(.medium))
                        .expandedWidth()
                    Text("Số điện thoại:")
                        .font(.system(size: 14).weight(.medium))
                    Text(account.phone_number ?? "")
                        .font(.system(size: 18).weight(.medium))
                        .expandedWidth()
                }
                Group {
                    Text("Quyền:")
                        .font(.system(size: 14).weight(.medium))
                    if account.isAdmin == true {
                        Text("Admin")
                            .font(.system(size: 18).weight(.medium))
                            .expandedWidth()
                    } else {
                        Text("User")
                            .font(.system(size: 18).weight(.medium))
                            .expandedWidth()
                    }
                }.padding(.bottom, 10)
            }.padding(.horizontal, 16)
                .gradientBorder()
                .cornerRadius(10)
            Spacer()
            NavigationLink(destination: UpdateAccountScreen(account: account),label: {
                Text("Cập nhật tài khoản")
                    .foregroundColor(.white)
                    .height(50)
                    .expandedWidth()
                    .gradientBackgound()
                    .padding(.horizontal, 16)
            })
            
        }.onAppear {
            viewModel.getAllAccount()
        }
        .padding(.horizontal, 16)
        .addNavigationBar(title: "Details Account",isHiddenCart: true)
        
        
    }
}


struct DetailsAccount_Previews: PreviewProvider {
    static var previews: some View {
        DetailsAccount(account: UserInfoObject())
    }
}
