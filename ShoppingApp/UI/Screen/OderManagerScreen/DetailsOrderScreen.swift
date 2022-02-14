//
//  DetailsOrderScreen.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 11/01/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailsOrderScreen: View {
    @ObservedObject var userInfo = UserInfo.shared
    @StateObject var viewModel: ProductManagerViewModel = .init()
    @State var order: Order
    @State var orderPrices : Double = 0
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 10){
                Group {
                    HStack{
                        Text("Mã đơn hàng:")
                            .font(.system(size: 14).weight(.medium))
                        Spacer()
                        if userInfo.currentUser?.isAdmin == true{
                            Button {
                                deleteOrder(order: order)
                            } label: {
                                Text("Delete")
                                    .foregroundColor(.white)
                                    .height(14)
                                    .frame(width: 100, height: 30, alignment: .center)
                                    .gradientBackgound()
                                    .padding(.horizontal, 16)
                            }
                        }
                    }
                    Text(order.id)
                        .font(.system(size: 18))
                        .expandedWidth()
                    Text("Số điện thoại:")
                        .font(.system(size: 14).weight(.medium))
                    Text(order.phoneNumber)
                        .font(.system(size: 18))
                        .expandedWidth()
                    Text("Email:")
                        .font(.system(size: 14).weight(.medium))
                    Text(order.email)
                        .font(.system(size: 18))
                        .expandedWidth()
                }
                Group{
                    Text("Địa chỉ:")
                        .font(.system(size: 14).weight(.medium))
                    Text(order.detailAdress)
                        .font(.system(size: 18))
                        .expandedWidth()
                    Text("Tỉnh thành:")
                        .font(.system(size: 14).weight(.medium))
                    Text(order.village)
                        .font(.system(size: 18))
                        .expandedWidth()
                    Text("Thành phố:")
                        .font(.system(size: 14).weight(.medium))
                    Text(order.city)
                        .font(.system(size: 18))
                        .expandedWidth()
                }
                Group{
                    Text("Trạng thái đơn hàng:")
                        .font(.system(size: 14).weight(.medium))
                    if order.isConfirm == true {
                        Text("Đã xác nhận")
                            .font(.system(size: 18).weight(.medium))
                            .foregroundColor(Color.blue)
                            .expandedWidth()
                    }
                    else {
                        Text("Chưa xác nhận")
                            .font(.system(size: 18).weight(.medium))
                            .foregroundColor(Color.red)
                            .expandedWidth()
                    }
                    Text("Tình trạng đơn hàng:")
                        .font(.system(size: 14).weight(.medium))
                    if order.isDelivery == true {
                        Text("Đã giao")
                            .font(.system(size: 18).weight(.medium))
                            .foregroundColor(Color.blue)
                            .expandedWidth()
                    }
                    else {
                        Text("Chưa giao")
                            .font(.system(size: 18).weight(.medium))
                            .foregroundColor(Color.red)
                            .expandedWidth()
                    }
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Thông tin đơn hàng:")
                        .font(.system(size: 14).weight(.medium))
                        .padding(.top, 10)
                    ForEach(order.items, id: \.self){ item in
                        if let product = viewModel.products.first(where: {$0.productID == item.productID}) {
                            HStack {
                                WebImage(url: URL(string: product.image.first ?? ""))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(10)
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(product.productName )
                                        .lineLimit(2)
                                        .font(.system(size: 16).bold())
                                    Text(product.price )
                                        .font(.system(size: 14).weight(.medium))
                                    Text("Số lượng: \(item.quantity)")
                                        .font(.system(size: 14))
                                    Text("Thành tiền: \(((product.price.doubleValue ) * Double(item.quantity)).formattedValue)")
                                        .font(.system(size: 14))
                                }
                            }
                        }
                    }
                    
                    Group {
                        let allprice = getPrice()
                        HStack {
                            
                            Text("Thành tiền:")
                                .font(.system(size: 14).weight(.bold))
                            Spacer()
                            Text("\(allprice)đ")
                                .font(.system(size: 14).weight(.medium))
                        }
                        HStack {
                            Text("Giảm giá:")
                                .font(.system(size: 14).weight(.bold))
                            Spacer()
                            Text("0đ")
                                .font(.system(size: 14).weight(.medium))
                        }
                        HStack {
                            Text("Giao hàng:")
                                .font(.system(size: 14).weight(.bold))
                            Spacer()
                            Text("0đ")
                                .font(.system(size: 14).weight(.medium))
                        }
                        Spacer().height(10)
                        Text("Tổng giá trị: \(allprice)đ")
                            .expandedWidth()
                        Text("(Giá đã bao gồm VAT nếu có)")
                            .font(.system(size: 12))
                            .expandedWidth()
                            .padding(.bottom, 10)
                        
                    }
                }.padding(.horizontal, 16)
                    .gradientBorder()
                    .cornerRadius(10)
            }
            .onAppear {
                viewModel.getAllProduct()
            }
            
        }
        .padding(.horizontal, 16)
    }
    
    func getPrice() -> Double {
        var price = 0.0
        order.items.forEach { item in
            if let product = viewModel.products.first(where: {$0.productID == item.productID}) {
                let newPrice = ((product.price.doubleValue ) * Double(item.quantity))
                price += newPrice
            }
        }
        return price
    }
    
    func deleteOrder(order: Order){
        OrdersRequest.shared.firRef.child(order.id).removeValue { (err, ref) in
            if err != nil {
                return
            }
        }
    }
    
}

struct DetailsOrderScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailsOrderScreen(order: Order())
    }
}
