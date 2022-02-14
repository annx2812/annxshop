//
//  ProductRequest.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 01/01/2022.
//

import Foundation
import Firebase

class ProductRequest {
    public static let shared = ProductRequest()
    var firRef: DatabaseReference
    private init() {
        self.firRef = BaseRequestModel.shared.firRef.child("Products")
    }
    
    func requestAllProduct(
        category: Category,
        successBlock: @escaping ([ProductModel]) -> Void,
        failBlock: @escaping (_ message: String) -> Void) {
            let request = firRef
                .queryOrdered(byChild: "category")
                .queryEqual(toValue: category.rawValue)
            request.observe(.value) { (snapShot) in
                var products = [ProductModel]()
                for child in snapShot.children {
                    if let snap = child as? DataSnapshot {
                        let key = snap.key
                        if let value = snap.value as? [String:Any],
                           var product = ProductModel.init(JSON: value) {
                            product.productID = key
                            products.append(product)
                        }
                    }
                }
                guard !products.isEmpty else {
                    failBlock("Không tìm thấy dữ liệu")
                    return
                }
                successBlock(products)
            }
        }
    
    func getAllProduct(
        successBlock: @escaping ([ProductModel]) -> Void,
        failBlock: @escaping (_ message: String) -> Void) {
            let request = firRef
                .queryOrdered(byChild: "Product")
            request.observe(.value) { (snapShot) in
                var products = [ProductModel]()
                for child in snapShot.children {
                    if let snap = child as? DataSnapshot {
                        let key = snap.key
                        if let value = snap.value as? [String:Any],
                           var product = ProductModel.init(JSON: value) {
                            product.productID = key
                            products.append(product)
                        }
                    }
                }
                guard !products.isEmpty else {
                    failBlock("Không tìm thấy dữ liệu")
                    return
                }
                successBlock(products)
            }
        }
    
    func requestSampleProductForCategory(
        category: String,
        successBlock: @escaping (_ products: [ProductModel])-> Void,
        failBlock: @escaping (_ message: String) -> Void) {
            let request = firRef
                .queryOrdered(byChild: "category")
                .queryEqual(toValue: category)
                .queryLimited(toFirst: 3)
            request.observe(.value) { (snapShot) in
                var products = [ProductModel]()
                for child in snapShot.children {
                    if let snap = child as? DataSnapshot {
                        let key = snap.key
                        if let value = snap.value as? [String:Any],
                           var product = ProductModel.init(JSON: value) {
                            product.productID = key
                            products.append(product)
                        }
                    }
                }
                guard !products.isEmpty else {
                    failBlock("Không tìm thấy dữ liệu")
                    return
                }
                successBlock(products)
            }
        }
    
    func addProduct(product: ProductModel, completionBlock: @escaping (Bool, ProductModel?)->Void) {
        var product = product
        let request: DatabaseReference = {
            if product.productID.isEmpty {
                return firRef.childByAutoId()
            } else {
                return firRef.child(product.productID)
            }
        }()
        
        let key = request.key ?? ""
        request.setValue(product.toJSON()) { (err, ref) in
            if err != nil {
                completionBlock(false, nil)
                return
            }
            product.productID = key
            completionBlock(true, product)
        }
    }
}
