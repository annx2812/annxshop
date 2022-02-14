//
//  UserDetail.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 01/01/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserDetail: View {
    var userInfo: UserInfoObject
    var userFuncs = UserInfoFunc.allCases
    @State var isNavToAccountDetail = false
    @State var isNavToOrderDetail = false
    @State var isNavToLoginDetail = false
    var body: some View {
        VStack {
            userHeader
            Divider().height(1)
                .foregroundColor(.black)
            userContent
                .padding(.horizontal, 16)
            Spacer()
        }.modifier(HideNavModifier())
            .addNavigationBar(title: "Thông tin", isHiddenBackButton: true)
            .onAppear {
                print("Hello")
            }
            .background(
                NavigationLink(isActive: $isNavToAccountDetail,
                               destination: {
                                   UserDetailScreen(userInfo: userInfo)
                }, label: {
                    EmptyView()
                })
            )
            .background(
                NavigationLink(isActive: $isNavToOrderDetail,
                               destination: {
                                   UserOrderScreen()
                }, label: {
                    EmptyView()
                })
            )
            .background(
                NavigationLink(isActive: $isNavToLoginDetail,
                               destination: {
                    HomeScreen()
                }, label: {
                    EmptyView()
                })
            )
        
    }
    
    // MARK: - Views
    var userHeader: some View {
        HStack() {
            if userInfo.imageUrl == "" {
                Image("ic_user")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .gradientBackgound()
                    .clipShape(Circle())
            }
            else{
                WebImage(url: URL(string: userInfo.imageUrl ?? ""))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .background(Color.gray)
                    .clipShape(Circle())
            }
            VStack(alignment: .leading, spacing: 2){
                Text(userInfo.userName ?? userInfo.email ?? "-")
                    .font(.system(size: 22).weight(.bold))
                Text(userInfo.getRank().title)
                    .font(.system(size: 14).weight(.light))
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 2, leading: 10, bottom: 2, trailing: 10))
                    .background(Capsule().foregroundColor(.blue))
            }
        }
        .padding(.horizontal, 16)
        .expandedWidth(alignment: .leading)
        .frame(height: 200, alignment: .bottom)
    }
    
    var userContent: some View {
        VStack {
            ForEach(userFuncs.indices, id: \.self) { index in
                let item = userFuncs[index]
                HStack {
                    item.icon.resizable()
                        .renderingMode(.template)
                        .gradientForeground()
                        .frame(width: 20, height: 20)
                    Text(item.title)
                        .font(.system(size: 14))
                    Spacer()
                    Image("ic_back")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .rotationEffect(Angle(degrees: 180))
                }.height(40)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        executeFunc(item)
                    }
            }
        }
    }
    // MARK: - Func
    func executeFunc(_ function: UserInfoFunc) {
        switch function {
        case .detailInfo:
            isNavToAccountDetail = true
        case .billHistory:
            isNavToOrderDetail = true
        case .help:
            ()
        case .logout:
            BaseRequestModel.shared.doLogOut()
           
        }
    }
    
}

struct UserDetail_Previews: PreviewProvider {
    static var previews: some View {
        UserDetail(userInfo: UserInfoObject())
    }
}
