//
//  Extensions.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 02/01/2022.
//

import Foundation

extension String {
    var doubleValue: Double {Double( self.replacingOccurrences(of: "[^0-9^,]", with: "", options: .regularExpression, range: nil)) ?? 0}
}

extension Double {
    var formattedValue: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.decimalSeparator = ","
        formatter.groupingSeparator = "."
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
