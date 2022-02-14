//
//  PaymentViewModel.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 02/01/2022.
//

import Foundation

class PaymentViewModel: ObservableObject {
    func submitOrder(name: String,
                     phoneNumber: String,
                     email: String,
                     city: String,
                     village: String,
                     detailAdress: String,
                     items: [CartItem],
                     completionBlock: @escaping (Bool) -> Void){
        var order = Order()
        order.name = name
        order.phoneNumber = phoneNumber
        order.email = email
        order.city = city
        order.village = village
        order.detailAdress = detailAdress
        order.items = items
        order.userId = UserInfo.shared.getUID()
        OrdersRequest.shared.setOrder(order: order) { isSuccess, _ in
            completionBlock(isSuccess)
        }
    }
}
