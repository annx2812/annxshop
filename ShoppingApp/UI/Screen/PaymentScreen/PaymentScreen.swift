//
//  PaymentScreen.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 02/01/2022.
//

import SwiftUI

struct PaymentScreen: View {
    @StateObject var viewModel: PaymentViewModel = .init()
    @State var name: String = ""
    @State var phoneNumber: String = ""
    @State var email: String = ""
    @State var city: String = ""
    @State var village: String = ""
    @State var detailAdress: String = ""
    @State var isNav: Bool = false
    @State var isConfirm: Bool = false
    var items: [CartItem]
    
    var body: some View {
        VStack {
            TextField("Tên người nhận", text: $name)
                .padding(.horizontal, 16)
                .height(40)
                .gradientBorder()
                .padding(.horizontal, 32)
            TextField("Số điện thoại", text: $phoneNumber)
                .padding(.horizontal, 16)
                .height(40)
                .gradientBorder()
                .padding(.horizontal, 32)
            TextField("Email", text: $email)
                .padding(.horizontal, 16)
                .height(40)
                .gradientBorder()
                .padding(.horizontal, 32)
            TextField("Tỉnh/Thành phố", text: $city)
                .padding(.horizontal, 16)
                .height(40)
                .gradientBorder()
                .padding(.horizontal, 32)
            TextField("Quận/ Huyện", text: $village)
                .padding(.horizontal, 16)
                .height(40)
                .gradientBorder()
                .padding(.horizontal, 32)
            TextField("Địa chỉ chi tiết", text: $detailAdress)
                .padding(.horizontal, 16)
                .height(40)
                .gradientBorder()
                .padding(.horizontal, 32)
            Spacer()
            Text("Thanh toán qua tiền mặt khi nhận hàng")
            Button {
                submitOrder()
            } label: {
                Text("Xác nhận")
                    .foregroundColor(.white)
                    .height(50)
                    .expandedWidth()
                    .gradientBackgound()
                    .padding(.horizontal, 16)
            }
        }.addNavigationBar(title: "Thông tin giao hàng", isHiddenCart: true)
            .background(NavigationLink(isActive: $isNav, destination: {
                HomeScreen()
            }, label: {
                EmptyView()
            }))
    }
    // MARK: - Func
    func submitOrder() {
        viewModel.submitOrder(name: name,
                              phoneNumber: phoneNumber,
                              email: email,
                              city: city,
                              village: village,
                              detailAdress: detailAdress,
                              items: items) { isSuccess in
            if isSuccess {
                CartInfo.shared.resetValue()
                isNav = true
            }
        }
    }
}

struct PaymentScreen_Previews: PreviewProvider {
    static var previews: some View {
        PaymentScreen(items: [])
    }
}
