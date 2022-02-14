//
//  CartItem.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 02/01/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct CartItemView: View {
    @State private var quantity = "0"
    @Binding var item: CartItem
    var onIncrease: ()-> Void
    var onValueChange: (String) -> Void
    var onDecrease: ()-> Void
    var body: some View {
        VStack {
            let product = item.product
            HStack {
                WebImage(url: URL(string: product?.image.first ?? ""))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
                VStack(alignment: .leading, spacing: 4) {
                    Text(product?.productName ?? "Laptop ASUS VivoBook Pro M3500QC-L1105T")
                        .lineLimit(2)
                        .font(.system(size: 16).bold())
                    Text(product?.price ?? "18.399.000")
                        .font(.system(size: 14).weight(.medium))
                    
                    HStack {
                        Button {
                            onDecrease()
                        } label: {
                            Text("-")
                                .font(.system(size: 14))
                                .frame(width: 20, height: 20)
                                .border(Color.gray, width: 1)
                                .multilineTextAlignment(.center)
                        }
                        TextField("", text: $quantity)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.center)
                            .width(40)
                            .onChange(of: quantity) { newValue in
                                onValueChange(newValue)
                            }
                        Button {
                            onIncrease()
                        } label: {
                            Text("+")
                                .font(.system(size: 16))
                                .frame(width: 20, height: 20)
                                .border(Color.gray, width: 1)
                                .multilineTextAlignment(.center)
                        }
                    }
                }
            }
        }.onAppear {
            quantity = "\(item.quantity)"
        }.onChange(of: item) { newValue in
            quantity = "\(item.quantity)"
        }
    }
}

struct CartItem_Previews: PreviewProvider {
    static var previews: some View {
        CartItemView(item: .constant(CartItem()), onIncrease: {}, onValueChange: {_ in}, onDecrease: {})
    }
}
