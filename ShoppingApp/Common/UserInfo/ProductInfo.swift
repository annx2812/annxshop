//
//  ProductInfo.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 07/01/2022.
//

import Foundation

class ProductDetails: ObservableObject {
    private init() {}
    static var shared = ProductDetails()
    
    @Published var productdetails: ProductModel = .init()
    
    func resetValue()  {
        ProductDetails.shared = .init()
    }
    
    func addDetails(key: String, value: String) {
            var details = ProductDetailModel()
            details.key = key
            details.value = value
        productdetails.detail.append(details)
    }
}
