//
//  CategoryViewModel.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 01/01/2022.
//

import Foundation

class DetailCategoryViewModel: ObservableObject {
    @Published var products: [ProductModel] = []
    
    func getAllProduct(forCategory category: Category) {
        ProductRequest.shared.requestAllProduct(category: category) { products in
            self.products = products
        } failBlock: { message in
            //
        }
    }
}
