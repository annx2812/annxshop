//
//  ConfirmOrderScreen.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 02/01/2022.
//

import SwiftUI

struct ConfirmOrderScreen: View {
    var items: [CartItem]
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                ForEach(items.indices, id: \.self) { index in
                    OrderItemView(item: items[index])
                    Divider().height(1)
                }
            }
            Divider().height(1)
            Group {
                HStack {
                    Text("Thành tiền:")
                        .font(.system(size: 14).weight(.bold))
                    Spacer()
                    Text("\(items.map({$0.getPrice()}).reduce(0, {$0 + $1}).formattedValue)đ")
                        .font(.system(size: 14).weight(.medium))
                }
                HStack {
                    Text("Giảm giá:")
                        .font(.system(size: 14).weight(.bold))
                    Spacer()
                    Text("0đ")
                        .font(.system(size: 14).weight(.medium))
                }
                HStack {
                    Text("Giao hàng:")
                        .font(.system(size: 14).weight(.bold))
                    Spacer()
                    Text("0đ")
                        .font(.system(size: 14).weight(.medium))
                }
                Spacer().height(10)
                Text("Tổng giá trị: \(items.map({$0.getPrice()}).reduce(0, {$0 + $1}).formattedValue)đ")
                Text("(Giá đã bao gồm VAT nếu có)")
                    .font(.system(size: 12))
                
            }.padding(.horizontal, 16)
            
            Divider().height(1)
            NavigationLink {
                PaymentScreen(items: items)
            } label: {
                Text("Thanh toán")
                    .foregroundColor(.white)
                    .height(50)
                    .expandedWidth()
                    .gradientBackgound()
                    .padding(.horizontal, 16)
            }
            Spacer().height(10)
        }
        .addNavigationBar(title: "Đặt hàng", isHiddenCart: true)
    }
}

struct ConfirmOrderScreen_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmOrderScreen(items: [])
    }
}
