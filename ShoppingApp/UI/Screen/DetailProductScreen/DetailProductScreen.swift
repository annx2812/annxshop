//
//  DetailProductScreen.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 01/01/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailProductScreen: View {
    @StateObject var viewModel: DetailProductViewModel = .init()
    @StateObject var userviewModel: AccountManagerViewModel = .init()
    @ObservedObject var userInfo = UserInfo.shared
    @State private var quantity: String = "1"
    @State var comment: String = ""
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
                    
                    Button {
                        if var qty = Int(quantity) {
                            qty -= 1
                            qty < 1 ? qty = 1 : nil
                            quantity = "\(qty)"
                        }
                    } label: {
                        Text("-")
                            .font(.system(size: 32))
                            .frame(width: 36, height: 36)
                            .border(Color.gray, width: 1)
                            .multilineTextAlignment(.center)
                    }
                    TextField("", text: $quantity)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                        .width(40)
                    Button {
                        if var qty = Int(quantity) {
                            qty += 1
                            quantity = "\(qty)"
                        }
                    } label: {
                        Text("+")
                            .font(.system(size: 32))
                            .frame(width: 36, height: 36)
                            .border(Color.gray, width: 1)
                            .multilineTextAlignment(.center)
                    }
                } .padding(.horizontal, 16)
                
                Button {
                    CartInfo.shared.addProductToCart(product: product, quantiy: Int(quantity) ?? 0)
                } label: {
                    HStack {
                        Image("ic_cart")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Thêm vào giỏ hàng")
                            .font(.system(size: 12))
                    }
                }.expandedWidth(alignment: .trailing)
                    .padding(.horizontal, 16)
                
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
                VStack(alignment: .leading, spacing: 10){
                    Text("Bình luận")
                        .font(.system(size: 18).weight(.medium))
                        .padding(.top, 10)
                    HStack{
                        if userInfo.currentUser?.isLogin == true{
                            if userInfo.currentUser?.imageUrl == ""{
                                Image("ic_user")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .gradientBackgound()
                                    .clipShape(Circle())
                            }
                            else
                            {
                                WebImage(url: URL(string: userInfo.currentUser?.imageUrl ?? ""))
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(10)
                                    .frame(width: 40, height: 40)
                                    .clipShape(Curve())
                            }
                            TextField("Bình luận", text: $comment)
                                .padding(.leading, 10)
                                .frame(width: 270, height: 40 )
                                .gradientBorder()
                            Button {
                                addNewComment()
                                comment = ""
                            } label: {
                                Text("Bình luận")
                                    .foregroundColor(.white)
                                    .font(.system(size: 12))
                                    .frame(width: 70, height: 40)
                                    .gradientBackgound()
                                    .cornerRadius(10)
                            }
                            Spacer()
                        }
                    }
                    let productComment = viewModel.comments.filter{$0.productID == product.productID}
                    ForEach(productComment, id: \.self){ item in
                        let userComment = userviewModel.accounts.filter{$0.UID == item.userID}
                        ForEach(userComment.indices, id: \.self){ index in
                            let users = userComment[index]
                            HStack {
                                if users.imageUrl == ""{
                                    Image("ic_user")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 40, height: 40)
                                        .gradientBackgound()
                                        .clipShape(Circle())
                                }
                                else
                                {
                                    WebImage(url: URL(string: users.imageUrl ?? ""))
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(10)
                                        .frame(width: 40, height: 40)
                                        .clipShape(Curve())
                                }
                                VStack(alignment: .leading, spacing: 10){
                                    Text(users.email ?? "")
                                        .font(.system(size: 14).weight(.medium))
                                    Text("\(item.comment )")
                                        .font(.system(size: 14).weight(.medium))
                                }.padding(.horizontal, 16)
                                    .padding(.vertical, 5)
                                    .expandedWidth(alignment: .leading)
                                .gradientBorder()
                                .cornerRadius(10)
                                Spacer()
                            }
                        }
                        
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 5)
            .onAppear {
                viewModel.getAllComment()
                userviewModel.getAllAccount()
            }
            
        }
        .expanded()
        .modifier(HideNavModifier())
        .addNavigationBar(title: "Chi tiết sản phẩm")
    }
    
    func addNewComment(){
        viewModel.addComment(productID: product.productID,
                             userID: UserInfo.shared.getUID(),
                             comment: comment) { isSuccess in
            if isSuccess {
            }
        }
    }
}

struct DetailProductScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailProductScreen(product: ProductModel())
    }
}
