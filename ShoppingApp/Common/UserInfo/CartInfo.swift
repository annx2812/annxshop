//
//  CartInfo.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 01/01/2022.
//

import Foundation

class CartInfo: ObservableObject {
    private init() {}
    static var shared = CartInfo()
    
    @Published var cart: Cart = .init()
    
    func resetValue()  {
        CartInfo.shared = .init()
    }
    
    func addProductToCart(product: ProductModel, quantiy: Int) {
        if let index = cart.items.firstIndex(where: {$0.productID == product.productID}) {
            cart.items[index].quantity += quantiy
        } else {
            var item = CartItem()
            item.product = product
            item.productID = product.productID
            item.quantity = quantiy
            cart.items.append(item)
        }
    }
}
