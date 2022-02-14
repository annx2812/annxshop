//
//  Object.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 01/01/2022.
//

import Foundation
import ObjectMapper

struct Product: Mappable {
    var objectID: String = ""
    var productName: String = ""
    var imageURLs: [String] = []
    var description: String = ""
    var providerID: String = ""
    var categories: [String] = []
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        productName <- map["productName"]
        imageURLs <- map["imageURLs"]
        description <- map["description"]
        providerID <- map["providerID"]
        categories <- map["categories"]
    }
}

struct Cart: Mappable {
    var id: String = ""
    var items: [CartItem] = []
    
    init() {}
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        items <- map["items"]
    }
}

struct CartItem: Mappable, Hashable {
    var productID: String = ""
    var quantity: Int = 0
    var product: ProductModel?
    var isSelected = false
    init() {}
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        productID <- map["productID"]
        quantity <- map["quantity"]
    }
    
    func getPrice() -> Double {
        ((product?.price.doubleValue ?? 0) * Double(quantity))
    }
}


