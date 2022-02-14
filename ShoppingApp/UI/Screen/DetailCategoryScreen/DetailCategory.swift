//
//  DetailCategory.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 01/01/2022.
//

import SwiftUI

struct DetailCategory: View {
    @StateObject var viewModel: DetailCategoryViewModel = .init()
    var category: Category
    @State var isSortMintoMax = false
    @State var isSortMaxtoMin = false
    @State var searchKeyWord: String = ""
    var body: some View {
        ScrollView {
           TextField("Tìm kiếm", text: $searchKeyWord)
                .height(40)
                .padding(.horizontal, 5)
                .gradientBorder()
                .padding(.horizontal, 16)
                .padding(.top, 5)
            HStack{
                Text("Sắp xếp theo:")
                    .lineLimit(2)
                    .font(.system(size: 14))
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 16)
                Spacer()
                Button {
                    isSortMaxtoMin = true
                    isSortMintoMax = false
                } label: {
                    Text("Giá giảm dần")
                        .foregroundColor(.white)
                        .font(.system(size: 12))
                        .height(20)
                        .expandedWidth()
                        .gradientBackgound()
                        .padding(.horizontal, 8)
                }
               
                Button {
                    isSortMintoMax = true
                    isSortMaxtoMin = false
                } label: {
                    Text("Giá tăng dần")
                        .foregroundColor(.white)
                        .font(.system(size: 12))
                        .height(20)
                        .expandedWidth()
                        .gradientBackgound()
                        .padding(.horizontal, 8)
                }
            }
            VStack {
                let column = Array(repeating: GridItem(.flexible()), count:3)
                LazyVGrid(columns: column) {
                    let products = { () -> [ProductModel] in
                        if isSortMaxtoMin {
                            return viewModel.products
                                .sorted{$0.price.doubleValue > $1.price.doubleValue}
                        } else if isSortMintoMax {
                            return viewModel.products
                                .sorted{$0.price.doubleValue < $1.price.doubleValue}
                        }
                        return viewModel.products
                    }().filter({searchKeyWord.isEmpty ? true : $0.productName.contains(searchKeyWord)})
                    ForEach(products, id: \.self) { product in
                        NavigationLink {
                            DetailProductScreen(product: product)
                        } label: {
                            ProductItem(product: product)
                        }
                    }
                }
            }.padding(.top, 5)
        }
        .expanded()
        .addNavigationBar(title: category.title)
        .onAppear(perform: {
            viewModel.getAllProduct(forCategory: category)
        })
        .modifier(HideNavModifier())
    }
}

struct DetailCategory_Previews: PreviewProvider {
    static var previews: some View {
        DetailCategory(category: .laptop)
    }
}
