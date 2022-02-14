//
//  OderManagerViewModel.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 07/01/2022.
//

import Foundation
import Firebase

class OrdersManagerViewModel: ObservableObject {
    @Published var orders: [Order] = []
    
    func getAllOrder() {
        OrdersRequest.shared.getAllOrder() { orders in
            self.orders = orders
        } failBlock: { message in
            //
        }
    }
    
    func updateOrder( id: String,
                      name: String,
                      phoneNumber: String,
                      email: String,
                      city: String,
                      village: String,
                      detailAdress: String,
                      userId: String,
                      items : [CartItem],
                      isConfirm: Bool,
                      isDelivery: Bool,
                     completionBlock: @escaping (Bool) -> Void){
        var order = Order()
        order.id = id
        order.name = name
        order.phoneNumber = phoneNumber
        order.email = email
        order.city = city
        order.village = village
        order.detailAdress = detailAdress
        order.userId = userId
        order.items = items
        order.isConfirm = isConfirm
        order.isDelivery = isDelivery
        OrdersRequest.shared.setOrder(order: order, completionBlock: { isSuccess, _ in
            completionBlock(isSuccess)
        })
    }
}
