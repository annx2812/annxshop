//
//  CategoryViewModel.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 30/12/2021.
//

import Foundation

class CategoryViewModel: ObservableObject {
    var categories: [Category]
    @Published var sampleProduct: [[ProductModel]]
    
    init() {
        self.categories = [.laptop, .phone, .pc, .screen]
        sampleProduct = Array(repeating: [], count: categories.count)
    }
    
    func getSampleData() {
        categories.indices.forEach { index in
            let category = categories[index]
            getSampleProduct(forCategory: category) { isSuccess, products in
                if isSuccess {
                    self.sampleProduct[index] = products
                }
            }
        }
    }
    
    func getSampleProduct(forCategory category: Category, completionBlock: @escaping (_ isSuccess: Bool, _ products: [ProductModel]) -> Void) {
        print("Request for \(category.title)")
        ProductRequest.shared.requestSampleProductForCategory(category: category.rawValue) { products in
            completionBlock(true, products)
        } failBlock: { message in
            completionBlock(false, [])
        }
    }
}
