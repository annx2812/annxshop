//
//  UserInfoObject.swift
//  FireBase001
//
//  Created by Hoang on 6/14/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import ObjectMapper

struct UserInfoObject: Mappable, Hashable {
    var UID = String()
    var userName: String?
    var email: String = ""
    var imageUrl: String?
    var birthDay: String?
    var phone_number: String?
    var rank: String?
    var isLogin = true
    var isAdmin = Bool()
    var gender : String?
    init() {}
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        UID <- map["UID"]
        userName <- map["userName"]
        email       <- map["email"]
        imageUrl    <- map["image_url"]
        birthDay    <- map["birthDay"]
        phone_number <- map["phone_number"]
        isLogin     <- map["isLogin"]
        isAdmin     <- map["isAdmin"]
        rank        <- map["rank"]
        gender      <- map["gender"]
    }
    
    func getRank() -> UserRank {
        return UserRank.allCases.first(where: {$0.rawValue == rank}) ?? .brone
    }
}

