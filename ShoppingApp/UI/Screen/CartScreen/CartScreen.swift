//
//  CartScreen.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 30/12/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct CartScreen: View {
    @ObservedObject var cartInfo = CartInfo.shared
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                ForEach(cartInfo.cart.items.indices, id: \.self) { index in
                    HStack {
                        CheckBox(checked: $cartInfo.cart.items[index].isSelected)
                        CartItemView(item: $cartInfo.cart.items[index]) {
                            cartInfo.cart.items[index].quantity += 1
                            
                            if cartInfo.cart.items[index].quantity == 0 {
                                cartInfo.cart.items.remove(at: index)
                            }
                        } onValueChange: { newValue in
                            cartInfo.cart.items[index].quantity = Int(newValue) ?? 1
                            if cartInfo.cart.items[index].quantity == 0 {
                                cartInfo.cart.items.remove(at: index)
                            }
                        } onDecrease: {
                            cartInfo.cart.items[index].quantity -= 1
                            if cartInfo.cart.items[index].quantity == 0 {
                                cartInfo.cart.items.remove(at: index)
                            }
                        }
                        Spacer()
                        Button {
                            cartInfo.cart.items.remove(at: index)
                        } label: {
                            Image("ic_trash")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .frame(width: 40, height: 40)
                        }
                    }.padding(.horizontal, 16)
                    Divider().height(1)
                }
            }
            NavigationLink {
                ConfirmOrderScreen(items: cartInfo.cart.items.filter({$0.isSelected}))
            } label: {
                Text("Đặt hàng")
                    .foregroundColor(.white)
                    .height(40)
                    .expandedWidth()
                    .gradientBackgound()
                    .padding(.horizontal, 16)
            }
        }.addNavigationBar(title: "Giỏ hàng")
    }
    
    // MARK: - Views
}

struct CartScreen_Previews: PreviewProvider {
    static var previews: some View {
        CartScreen()
    }
}
