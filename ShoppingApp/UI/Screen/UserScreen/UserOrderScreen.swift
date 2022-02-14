//
//  UserOrderScreen.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 13/01/2022.
//

import SwiftUI

struct UserOrderScreen: View {
    @StateObject var viewModel: OrdersManagerViewModel = .init()
    var body: some View {
        Text("Lịch sử mua hàng")
            .font(.system(size: 20).weight(.medium))
            .gradientForeground()
        VStack(alignment: .leading, spacing: 10){
            let orders = viewModel.orders.filter{$0.userId == UserInfo.shared.getUID()}
            ForEach(orders, id: \.self) { item in
                NavigationLink {
                    DetailsOrderScreen(order: item)
                } label: {
                    VStack(alignment: .leading, spacing: 0){
                        HStack{
                            Text("Mã đơn hàng:")
                                .font(.system(size: 14).weight(.medium))
                            Text("\(item.id)")
                                .font(.system(size: 14).weight(.medium))
                            Spacer()
                        }
                        HStack{
                            Text("Email:")
                                .font(.system(size: 14).weight(.medium))
                            Text("\(item.email)")
                                .font(.system(size: 14).weight(.medium))
                            Spacer()
                        }
                    }.foregroundColor(.black)
                        .expandedWidth(alignment: .leading)
                        .padding(.leading, 16)
                        .gradientBorder()
                            .cornerRadius(12)
                }
            }
        }.onAppear(perform: {
            viewModel.getAllOrder()
        })
            .padding(.horizontal, 16)
        Spacer()
    }
}

struct UserOrderScreen_Previews: PreviewProvider {
    static var previews: some View {
        UserOrderScreen()
    }
}
