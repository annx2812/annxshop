//
//  ProductItem.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 01/01/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductItem: View {
    var product: ProductModel
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            WebImage(url: URL(string: product.image.first ?? ""))
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .cornerRadius(10)
            Text(product.productName)
                .lineLimit(2)
                .font(.system(size: 14))
                .multilineTextAlignment(.leading)
            Text(product.price)
                .font(.system(size: 14).weight(.medium))
                .foregroundColor(.blue)
            Text(product.price)
                .font(.system(size: 12).weight(.light))
                .strikethrough()
        }.width(100)
            .padding(5)
            .gradientBorder()
    }
}

struct ProductItem_Previews: PreviewProvider {
    static var previews: some View {
        ProductItem(product: ProductModel())
    }
}
