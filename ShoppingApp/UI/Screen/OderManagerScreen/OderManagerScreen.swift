//
//  OderManagerScreen.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 07/01/2022.
//

import SwiftUI

struct OderManagerScreen: View {
    @StateObject var viewModel: OrdersManagerViewModel = .init()
    @State var isConfirm = false
    @State var searchKeyWord: String = ""
    var body: some View {
        ScrollView{
            TextField("Tìm kiếm", text: $searchKeyWord)
                 .height(40)
                 .padding(.horizontal, 5)
                 .gradientBorder()
                 .padding(.horizontal, 16)
                 .padding(.top, 5)
            Picker(selection: $isConfirm, label: Text("Picker")){
                Text("Chưa xác nhận")
                    .tag(false)
                Text("Đã xác nhận")
                    .tag(true)
            }.pickerStyle(SegmentedPickerStyle())
                .padding()
            if !isConfirm {
                VStack(spacing: 10){
                    let orders1 = viewModel.orders
                        .filter{$0.isConfirm == false}
                        .filter({searchKeyWord.isEmpty ? true : $0.email.contains(searchKeyWord)})
                    ForEach(orders1, id: \.self) { item in
                        NavigationLink {
                            DetailsOrderScreen(order: item)
                        } label: {
                            HStack {
                                OrdersList(order: item)
                                    .expandedWidth(alignment: .leading)
                                    .padding(.leading, 16)
                                Button {
                                    confirmOrder(order: item)
                                } label: {
                                    Image(systemName: "checkmark.square")
                                        .foregroundColor(Color.black)
                                        .padding(.leading)
                                }
                                Spacer()
                            }.gradientBorder()
                                .cornerRadius(12)
                        }.padding(.horizontal, 16)
                    }
                }
                
            }
            else {
                VStack(spacing: 10){
                    let orders2 = viewModel.orders
                        .filter{$0.isConfirm == true}
                        .filter({searchKeyWord.isEmpty ? true : $0.email.contains(searchKeyWord)})
                    ForEach(orders2, id: \.self) { item in
                        NavigationLink {
                            DetailsOrderScreen(order: item)
                        } label: {
                            HStack {
                                OrdersList(order: item)
                                    .expandedWidth(alignment: .leading)
                                    .padding(.leading, 16)
                                if item.isDelivery == false{
                                    Button {
                                        confirmDelivery(order: item)
                                    } label: {
                                        Image(systemName: "checkmark.square")
                                            .foregroundColor(Color.black)
                                            .padding(.leading, 16)
                                    }
                                }
                                Spacer()
                            }.gradientBorder()
                                .cornerRadius(12)
                        }.padding(.horizontal, 16)
                    }
                }
            }
        }
        .onAppear(perform: {
            viewModel.getAllOrder()
        })
        .addNavigationBar(title: "Order Manager", isHiddenCart: true)
    }
    
    func confirmOrder(order: Order){
        viewModel.updateOrder(id: order.id,
                              name: order.name,
                              phoneNumber: order.phoneNumber,
                              email: order.email,
                              city: order.city,
                              village: order.village,
                              detailAdress: order.detailAdress,
                              userId: order.userId,
                              items: order.items,
                              isConfirm: true,
                              isDelivery: order.isDelivery) { isSuccess in
            if isSuccess {
                //onAddSuccess()
            }
        }
    }
    
    func confirmDelivery(order: Order){
        viewModel.updateOrder(id: order.id,
                              name: order.name,
                              phoneNumber: order.phoneNumber,
                              email: order.email,
                              city: order.city,
                              village: order.village,
                              detailAdress: order.detailAdress,
                              userId: order.userId,
                              items: order.items,
                              isConfirm: order.isConfirm,
                              isDelivery: true) { isSuccess in
            if isSuccess {
                //onAddSuccess()
            }
        }
    }
    
    func deleteOrder(order: Order){
        OrdersRequest.shared.firRef.child(order.id).removeValue { (err, ref) in
            if err != nil {
                return
            }
        }
    }
    
}

struct OderManagerScreen_Previews: PreviewProvider {
    static var previews: some View {
        OderManagerScreen()
    }
}
