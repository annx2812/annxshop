//
//  ManagerScreen.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 05/01/2022.
//

import SwiftUI

struct ManagerScreen: View {
    var userInfo: UserInfoObject
    var managers = Manager.allCases
    var body: some View {
            VStack {
                Text("Danh mục quản lý")
                    .font(.system(size: 14).weight(.medium))
                    .expandedWidth(alignment: .leading)
                    .padding(.leading, 16)
                let column = Array(repeating: GridItem(.flexible()), count:3)
                LazyVGrid(columns: column) {
                    ForEach(managers.indices, id: \.self) { index in
                        let manager = managers[index]
                        NavigationLink {
                            switch manager {
                            case .account:
                                AccountManagerScreen()
                            case .product:
                                ProductManagerScreen()
                            case .order:
                                OderManagerScreen()
                            }
                            
                        } label: {
                            VStack {
                                manager.icon
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .frame(width: 40, height: 40)
                                    .gradientForeground()
                                    .background(Color.gray.opacity(0.2))
                                    .clipShape(Curve())
                                Text(manager.title)
                                    .font(.system(size: 14))
                            }
                        }
                    }
                }
                Spacer()
                Button {
                    BaseRequestModel.shared.doLogOut()
                } label: {
                    Text("Đăng xuất")
                        .foregroundColor(.white)
                        .height(50)
                        .expandedWidth()
                        .gradientBackgound()
                        .padding(.horizontal, 16)
                }
            }
        .addNavigationBar(title: "Manager", isHiddenBackButton: true, isHiddenCart: true)
        .modifier(HideNavModifier())
    }
}

struct ManagerScreen_Previews: PreviewProvider {
    static var previews: some View {
        ManagerScreen(userInfo: UserInfoObject())
    }
}
