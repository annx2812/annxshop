//
//  ProductManagerViewModel.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 05/01/2022.
//

import SwiftUI
import Foundation
import Photos

class ProductManagerViewModel: ObservableObject {
    @Published var products: [ProductModel] = []
    
    func getAllProduct() {
        ProductRequest.shared.getAllProduct() { products in
            self.products = products
        } failBlock: { message in
            //
        }
    }
    
    
    func addProduct( productName: String,
                     description: String,
                     price: String,
                     company: String,
                     category: String,
                     image: [String],
                     details: [ProductDetailModel],
                     completionBlock: @escaping (Bool) -> Void){
        var product = ProductModel()
        product.productName = productName
        product.description = description
        product.price = price
        product.company = company
        product.category = category
        product.image = image
        product.detail = details
        ProductRequest.shared.addProduct(product: product) { isSuccess, _ in
            completionBlock(isSuccess)
        }
    }
    
    
    
}


