//
//  UserDetailScreen.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 13/01/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserDetailScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var userInfo : UserInfoObject
    var body: some View {
            VStack(alignment: .leading){
                Text("Ảnh cá nhân:")
                    .font(.system(size: 14).weight(.medium))
                if UserInfo.shared.currentUser?.imageUrl == ""{
                    Image("ic_user")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .expandedWidth()
                        .gradientBackgound()
                        .clipShape(Circle())
                }
                else {
                    WebImage(url: URL(string: UserInfo.shared.currentUser?.imageUrl ?? ""))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                        .clipShape(Curve())
                        .expandedWidth()
                }
                VStack(alignment: .leading,spacing: 10){
                    Group{
                    Text("Email:")
                        .font(.system(size: 14).weight(.medium))
                        .padding(.top, 10)
                    Text(UserInfo.shared.currentUser?.email ?? "")
                        .font(.system(size: 18))
                        .expandedWidth()
                    Text("Tên người dùng:")
                        .font(.system(size: 14).weight(.medium))
                    Text(UserInfo.shared.currentUser?.userName ?? "")
                        .font(.system(size: 18))
                        .expandedWidth()
                    Text("Giới tính:")
                        .font(.system(size: 14).weight(.medium))
                    Text(UserInfo.shared.currentUser?.gender ?? "")
                        .font(.system(size: 18))
                        .expandedWidth()
                    Text("Ngày sinh:")
                        .font(.system(size: 14).weight(.medium))
                    Text(UserInfo.shared.currentUser?.birthDay ?? "")
                        .font(.system(size: 18))
                        .expandedWidth()
                    Text("Số điện thoại:")
                        .font(.system(size: 14).weight(.medium))
                    Text(UserInfo.shared.currentUser?.phone_number ?? "")
                        .font(.system(size: 18))
                        .expandedWidth()
                        .padding(.bottom, 10)
                    }
                }.padding(.horizontal, 16)
                .gradientBorder()
                    .cornerRadius(10)
                Spacer()
                NavigationLink(destination: UpdateUserScreen(account: userInfo, onUpdateSuccess: {
                    presentationMode.wrappedValue.dismiss()
                })) {
                    Text("Cập nhật tài khoản")
                        .foregroundColor(.white)
                        .height(50)
                        .expandedWidth()
                        .gradientBackgound()
                        .padding(.horizontal, 16)
                }
            }.onAppear(perform: {
                
            })
            .padding(.horizontal, 16)
        .addNavigationBar(title: "Thông tin cá nhân", isHiddenBackButton: false, isHiddenCart: true)
        
        
    }
}

struct UserDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailScreen(userInfo: UserInfoObject())
    }
}
