//
//  TardisBaseMapObject.swift
//  FireBase001
//
//  Created by Hoang on 7/6/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import ObjectMapper

protocol BaseMapObject: Mappable {
    init?(map: Map)
    func mapping(map: Map)
    var id: String {get set}
}
