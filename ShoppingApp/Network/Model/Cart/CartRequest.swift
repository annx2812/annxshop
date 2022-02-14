//
//  CartRequest.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 02/01/2022.
//

import Foundation
import Firebase

class OrdersRequest {
    public static let shared = OrdersRequest()
    var firRef: DatabaseReference
    private init() {
        self.firRef = BaseRequestModel.shared.firRef.child("Orders")
    }
    
    func setOrder(order: Order, completionBlock: @escaping (Bool, Order?)->Void) {
        var order = order
        let request: DatabaseReference = {
            if order.id.isEmpty {
                return firRef.childByAutoId()
            } else {
                return firRef.child(order.id)
            }
        }()
       
        let key = request.key ?? ""
        request.setValue(order.toJSON()) { (err, ref) in
            if err != nil {
                completionBlock(false, nil)
                return
            }
            order.id = key
            completionBlock(true, order)
        }
    }
    
    func getAllOrder(
        successBlock: @escaping ([Order]) -> Void,
        failBlock: @escaping (_ message: String) -> Void) {
            let request = firRef
                .queryOrdered(byChild: "Orders")
            request.observe(.value) { (snapShot) in
                var orders = [Order]()
                for child in snapShot.children {
                    if let snap = child as? DataSnapshot {
                        let key = snap.key
                        if let value = snap.value as? [String:Any],
                           var order = Order.init(JSON: value) {
                            order.id = key
                            orders.append(order)
                        }
                    }
                }
                guard !orders.isEmpty else {
                    failBlock("Không tìm thấy dữ liệu")
                    return
                }
                successBlock(orders)
            }
        }
}
