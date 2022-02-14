//
//  ItemsObject.swift
//  DoAn
//
//  Created by Nguyễn Hoàng on 26/12/2021.
//

import Foundation
import ObjectMapper

struct ProductModel: Mappable, Hashable {
    var productID = ""
    var productName = "-"
    var description = "-"
    var price = "-"
    var company = "-"
    var category = "-"
    var image = [String]()
    var detail = [ProductDetailModel]()
    
    init() {}
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        productName     <- map["product_name"]
        price           <- map["price"]
        company         <- map["company"]
        category        <- map["category"]
        image           <- map["image"]
        description     <- map["description"]
        detail          <- map["detail"]
    }
}

//struct AccountModel: Mappable, Hashable {
//    
//}

struct ProductDetailModel: Mappable, Hashable {
    var key: String = "-"
    var value: String = "-"
    init(){}
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        key     <- map["key"]
        value   <- map["value"]
    }
}

struct Order: Mappable, Hashable {
    var id: String = ""
    var name = "-"
    var phoneNumber = "-"
    var email = "-"
    var city = "-"
    var village = "-"
    var detailAdress = "-"
    var userId = String()
    var items = [CartItem]()
    var createDate = Date().timeIntervalSince1970
    var isConfirm: Bool = false
    var isDelivery: Bool = false
    
    init(){}
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        name            <- map["name"]
        phoneNumber     <- map["phoneNumber"]
        email           <- map["email"]
        city            <- map["city"]
        village         <- map["village"]
        detailAdress    <- map["detailAdress"]
        items           <- map["items"]
        createDate      <- map["createDate"]
        isConfirm       <- map["isConfirm"]
        isDelivery      <- map["isDelivery"]
        userId          <- map["userId"]
    }
}

struct Comment: Mappable, Hashable {
    var commentID: String = ""
    var productID: String = ""
    var userID: String = ""
    var comment: String = ""
    init(){}
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        commentID   <- map["commentID"]
        productID   <- map["productID"]
        userID      <- map["userID"]
        comment     <- map["comment"]
    }
}
