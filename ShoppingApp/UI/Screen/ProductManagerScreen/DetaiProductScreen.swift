//
//  DetaiProductScreen.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 17/01/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetaiProductScreen: View {
    var product: ProductModel
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Group {
                    TabView {
                        ForEach(product.image.indices, id: \.self) { index in
                            let imageUrl = URL(string: product.image[index])
                            WebImage(url: imageUrl)
                                .resizable()
                                .scaledToFit()
                                .tag(index)
                        }
                    }.tabViewStyle(PageTabViewStyle())
                        .expandedWidth()
                        .cornerRadius(10)
                        .height(400)
                    Text(product.productName)
                        .font(.system(size: 20).bold())
                }
                .padding(.horizontal, 16)
                Divider().height(1)
                HStack {
                    Text(product.price)
                        .font(.system(size: 22).bold())
                        .foregroundColor(.blue)
                        .expandedWidth(alignment: .leading)
                } .padding(.horizontal, 16)
                Divider().height(1)
                Group {
                    Text("Thông số kĩ thuật")
                        .font(.system(size: 14))
                    let columns = Array(repeating: GridItem(alignment: .leading),
                                        count: 2)
                    LazyVGrid(columns: columns) {
                        ForEach(product.detail.indices, id: \.self) { index in
                            let detail = product.detail[index]
                            Text(detail.key)
                                .font(.system(size: 14).weight(.medium))
                            Text(detail.value)
                                .font(.system(size: 14))
                        }
                    }
                }
                .padding(.horizontal, 16)
                Divider().height(1)
                Group {
                    Text("Chi tiết sản phẩm")
                        .font(.system(size: 14).weight(.medium))
                    Text(product.description)
                        .font(.system(size: 14))
                }.padding(.horizontal, 16)
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 5)
        .expanded()
        .modifier(HideNavModifier())
        .addNavigationBar(title: "Chi tiết sản phẩm", isHiddenCart: true)
    }
}



struct DetaiProductScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetaiProductScreen(product: ProductModel())
    }
}
