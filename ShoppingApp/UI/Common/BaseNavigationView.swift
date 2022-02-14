//
//  NavigationView.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 01/01/2022.
//

import SwiftUI

struct BaseNavigationView<Content: View>: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject private var cartModel = CartInfo.shared
    private let title: String
    private let content: Content
    private let isHiddenBackButton: Bool
    private let isHiddenCart: Bool
    init(title: String, isHiddenBackButton: Bool = false, isHiddenCart: Bool = false, @ViewBuilder content: ()-> Content) {
        self.title = title
        self.content = content()
        self.isHiddenBackButton = isHiddenBackButton
        self.isHiddenCart = isHiddenCart
    }
    var body: some View {
        ZStack(alignment: .top) {
            content
                .padding(.top, 70)
            VStack {
                ZStack {
                    HStack(alignment: .top) {
                        if !isHiddenBackButton {
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image("ic_back")
                                    .renderingMode(.template)
                                    .resizable()
                                    .foregroundColor(.white)
                                    .frame(width: 16, height: 16)
                                Text("Trở về")
                                    .font(.system(size: 16).weight(.medium))
                                    .foregroundColor(.white)
                            }
                        }
                        Spacer()
                        if !isHiddenCart {
                            NavigationLink  {
                                CartScreen()
                            } label: {
                                HStack {
                                    Image("ic_cart")
                                        .resizable()
                                        .renderingMode(.template)
                                        .foregroundColor(.white)
                                        .frame(width: 20, height: 20)
                                    let numberOfItem = cartModel.cart.items.map({ Int($0.quantity) }).reduce(0, {$0 + $1})
                                    Text("\(numberOfItem)")
                                        .foregroundColor(numberOfItem == 0 ? .white : .red)
                                        .font(.system(size: 12))
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    
                    
                    Text(title)
                        .font(.system(size: 20,
                                      weight: .bold,
                                      design: .default))
                        .foregroundColor(.white)
                        .expandedWidth()
                    
                }
                .height(50)
                .background(
                    VStack(spacing: 0) {
                        LinearGradient(gradient: .init(colors: [.blue, .green]),
                                       startPoint: .leading,
                                       endPoint: .trailing)
                            .ignoresSafeArea()
                        LinearGradient(gradient: .init(colors: [.blue, .green]),
                                       startPoint: .leading,
                                       endPoint: .trailing)
                            .clipShape(BottomCurve())
                    }
                    
                       
                )
                
            }.expandedWidth()
        }.modifier(HideNavModifier())
    }
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        BaseNavigationView(title: ""){ EmptyView()}
    }
}
