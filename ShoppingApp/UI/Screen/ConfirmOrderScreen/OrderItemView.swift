//
//  OrderItemView.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 02/01/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct OrderItemView: View {
    var item: CartItem
    var body: some View {
        VStack(alignment: .leading) {
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
                    Text("Số lượng: \(item.quantity)")
                        .font(.system(size: 14))
                    Text("Thành tiền: \(((product?.price.doubleValue ?? 0) * Double(item.quantity)).formattedValue)")
                        .font(.system(size: 14))
                }
            }
        }.padding(.horizontal, 16)
    }
}

struct OrderItemView_Previews: PreviewProvider {
    static var previews: some View {
        OrderItemView(item: CartItem())
    }
}
