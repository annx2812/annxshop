//
//  ProductManagerScreen.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 05/01/2022.
//

import SwiftUI
import SDWebImageSwiftUI
import Photos
import LottieCore

struct ProductManagerScreen: View {
    @StateObject var viewModel: ProductManagerViewModel = .init()
    @State var showSheet: Bool = false
    @State var searchKeyWord: String = ""
    var categorys = Category.allCases
    var body: some View {
        TextField("Tìm kiếm", text: $searchKeyWord)
             .height(40)
             .padding(.horizontal, 5)
             .gradientBorder()
             .padding(.horizontal, 16)
             .padding(.top, 5)

        List{
            ForEach(categorys.indices, id: \.self){ index in
                let category1 = categorys[index]
                Section(header: Text(category1.title)){
                    let categoryProduct = viewModel.products
                        .filter{$0.category == category1.rawValue}
                        .filter({searchKeyWord.isEmpty ? true : $0.productName.contains(searchKeyWord)})
                    ForEach(categoryProduct.indices, id: \.self) { index in
                        let cateProduct = categoryProduct[index]
                        NavigationLink {
                            DetaiProductScreen(product: cateProduct)
                        } label: {
                            HStack {
                                WebImage(url: URL(string: cateProduct.image.first ?? ""))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(10)
                                    .clipShape(Curve())
                                Text("\(cateProduct.productName)")
                                    .font(.system(size: 14).weight(.medium))
                                Spacer()
                            }
                        }
                    }
                    .onDelete { IndexSet in
                        for i in IndexSet
                        {
                            let delproduct = categoryProduct[i]
                            deleteProduct(product: delproduct)
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.getAllProduct()
        }
        .navigationTitle("Sản Phẩm")
        .navigationBarItems(
            trailing: Button("+",action: {
                showSheet.toggle()
            })
                .font(.system(size: 30))
        ).sheet(isPresented: $showSheet, content: {
            AddNewProductScreen() {
                showSheet = false
            }
        })
    }
    
    func deleteProduct(product: ProductModel){
        ProductRequest.shared.firRef.child(product.productID).removeValue { (err, ref) in
            if err != nil {
                return
            }
        }
    }
}

struct ProductManagerScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProductManagerScreen()
    }
}
