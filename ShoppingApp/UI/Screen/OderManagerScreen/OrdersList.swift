//
//  OrdersList.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 11/01/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct OrdersList: View {
    @State var order: Order
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            HStack{
                Text("Mã đơn hàng:")
                    .font(.system(size: 14).weight(.medium))
                Text("\(order.id)")
                    .font(.system(size: 14).weight(.medium))
                Spacer()
            }
            HStack{
                Text("Email:")
                    .font(.system(size: 14).weight(.medium))
                Text("\(order.email)")
                    .font(.system(size: 14).weight(.medium))
                Spacer()
            }
        }.foregroundColor(.black)
    }
}

struct OrdersList_Previews: PreviewProvider {
    static var previews: some View {
        OrdersList(order: Order())
    }
}
