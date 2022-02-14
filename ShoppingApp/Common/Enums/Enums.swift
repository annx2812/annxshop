//
//  Enums.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 30/12/2021.
//

import Foundation
import SwiftUI

enum HomeTab: CaseIterable {
    case category, user
    
    var title: String {
        switch self {
        case .category:
            return "Home"
        case .user:
            return "User"
        }
    }
    
    var icon: Image {
        switch self {
        case .category:
            return Image("ic_home")
        case .user:
            return Image("ic_user")
        }
    }
}

enum Manager: String, CaseIterable{
    case account, product, order
    var title: String {
        switch self {
        case .account:
            return "Tài khoản"
        case .product:
            return "Sản phẩm"
        case .order:
            return "Đơn hàng"
        }
    }
    
    var icon: Image {
        switch self {
        case .account:
            return Image("ic_user")
        case .product:
            return Image("ic_lap")
        case .order:
            return Image("ic_order")
        }
    }
}

enum Category: String, CaseIterable {
case laptop, phone, pc, screen, gamingGear, mouse, keyboard
    var title: String {
        switch self {
        case .laptop:
            return "Laptop"
        case .phone:
            return "Điện thoại"
        case .pc:
            return "Máy tính"
        case .screen:
            return "Màn hình"
        case .gamingGear:
            return "Gaming Gear"
        case .mouse:
            return "Chuột"
        case .keyboard:
            return "Phím"
        }
    }
    
    var icon: Image {
        switch self {
        case .laptop:
            return Image("ic_lap")
        case .phone:
            return Image("ic_phone")
        case .pc:
            return Image("ic_pc")
        case .screen:
            return Image("ic_screen")
        case .gamingGear:
            return Image("ic_gear")
        case .mouse:
            return Image("ic_mouse")
        case .keyboard:
            return Image("ic_keyboard")
        }
    }
}
// MARK: - User
enum UserType {
    case manager, staff, normal
    
    var typeName: String {
        switch self {
        case .manager:
            return "Quản lý"
        case .staff:
            return "Nhân viên"
        case .normal:
            return "Người dùng"
        }
    }
}

// MARK: - Product
/// Theo priority, discount chỉ được tính 1 lần, lần lượt theo product, nhà sản xuất và theo category của mặt hàng
enum DiscountType {
    case product, category, provider
    
    
}
// MARK: - User info
enum UserRank: String, CaseIterable {
    case brone, silver, gold, plantium, diamond
    
    var title: String {
        switch self {
        case .brone:
            return "Hội viên đồng"
        case .silver:
            return "Hội viên bạc"
        case .gold:
            return "Hội viên vàng"
        case .plantium:
            return "Hội viên bạch kim"
        case .diamond:
            return "Hội viên kim cương"
        }
    }
}
enum UserInfoFunc: CaseIterable {
    case detailInfo, billHistory, help, logout
    
    var title: String {
        switch self {
        case .detailInfo:
            return "Chi tiết"
        case .billHistory:
            return "Lịch sử mua"
        case .help:
            return "Trợ giúp"
        case .logout:
            return "Đăng xuất"
        }
    }
    
    var icon: Image {
        switch self {
        case .detailInfo:
            return Image("user_detail")
        case .billHistory:
            return Image("ic_list")
        case .help:
            return Image("ic_help")
        case .logout:
            return Image("ic_sign_out")
        }
    }
}
