//
//  CategoryScreen.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 30/12/2021.
//

import SwiftUI

struct CategoryScreen: View {
    @StateObject var viewModel: CategoryViewModel = .init()
    var categories = Category.allCases
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Text("Danh mục sản phẩm")
                    .font(.system(size: 14).weight(.medium))
                    .expandedWidth(alignment: .leading)
                    .padding(.leading, 16)
                let column = Array(repeating: GridItem(.flexible()), count:4)
                LazyVGrid(columns: column) {
                    ForEach(categories.indices, id: \.self) { index in
                        let category = categories[index]
                        NavigationLink {
                            DetailCategory(category: category)
                        } label: {
                            VStack {
                                category.icon
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .frame(width: 40, height: 40)
                                    .gradientForeground()
                                    .background(Color.gray.opacity(0.2))
                                    .clipShape(Curve())
                                Text(category.title)
                                    .font(.system(size: 14))
                            }
                        }
                    }
                }
                ForEach(viewModel.categories.indices, id: \.self) { index in
                    let category = viewModel.categories[index]
                    let products = viewModel.sampleProduct[index]
                    Divider().height(1)
                    getSampleView(category: category, products: products)
                }
            }
        }
        .addNavigationBar(title: "Trang chủ", isHiddenBackButton: true)
        .modifier(HideNavModifier())
        .onAppear {
            viewModel.getSampleData()
        }
    }
    // MARK: - Views
    func getSampleView(category: Category, products: [ProductModel]) -> some View {
        VStack {
            HStack {
                category.icon
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 16, height: 16)
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .gradientBackgound()
                    .clipShape(Curve())
                Text("\(category.title) nổi bật")
                    .font(.system(size: 14).weight(.medium))
                Spacer()
               
            }
            HStack(alignment: .top) {
                ForEach(products.indices, id: \.self) { index in
                    let product = products[index]
                    NavigationLink {
                        DetailProductScreen(product: product)
                    } label: {
                        ProductItem(product: product)
                    }
                }
            }
        }.padding(.horizontal, 16)
            .padding(.bottom, 16)
    }
}

struct CategoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        CategoryScreen()
    }
}
