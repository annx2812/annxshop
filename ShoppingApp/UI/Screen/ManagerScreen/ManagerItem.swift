//
//  ManagerItem.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 04/01/2022.
//

import SwiftUI

struct ManagerItem: View {
    var manager: Manager
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            manager.icon
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .cornerRadius(10)
            Text(manager.title)
                .lineLimit(2)
                .font(.system(size: 14))
                .multilineTextAlignment(.center)
        }.width(100)
            .padding(5)
            .gradientBorder()
    }
}

struct ManagerItem_Previews: PreviewProvider {
    static var previews: some View {
        ManagerItem(manager: .product)
    }
}
