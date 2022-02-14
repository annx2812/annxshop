//
//  AddProductScreen.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 05/01/2022.
//

import SwiftUI
import PhotosUI

struct AddNewProductScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel: ProductManagerViewModel = .init()
    @State var productimage : UIImage?
    @State var image: [String] = []
    @State var imageUrl : String = ""
    @State var showImagePicker = false
    @State var name: String = ""
    @State var company: String = ""
    @State var description: String = ""
    @State var price: String = ""
    @State var key: String = ""
    @State var value: String = ""
    @State var category: String = ""
    @State var loginStatusMessage = ""
    var onAddSuccess: ()-> Void
    var categories = Category.allCases
    var body: some View{
        VStack {
            Text("Chọn ảnh sản phẩm:")
                .font(.system(size: 17).weight(.medium))
                .expandedWidth(alignment: .leading)
                .padding(.leading, 16)
                .padding(.top, 20)
            Button {
                showImagePicker.toggle()
            } label: {
                if let productimage = self.productimage {
                    Image(uiImage: productimage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 128, height: 128)
                        .cornerRadius(64)
                } else {
                    Image(systemName: "person.fill")
                        .font(.system(size: 64))
                        .padding()
                        .foregroundColor(Color(.label))
                }
            }
            Group{
                TextField("Tên sản phẩm", text: $name)
                    .padding(.horizontal, 16)
                    .height(40)
                    .gradientBorder()
                    .padding(.horizontal, 32)
                TextField("Tên công ty", text: $company)
                    .padding(.horizontal, 16)
                    .height(40)
                    .gradientBorder()
                    .padding(.horizontal, 32)
                TextField("Mô tả sản phẩm", text: $description)
                    .padding(.horizontal, 16)
                    .height(40)
                    .gradientBorder()
                    .padding(.horizontal, 32)
                
            }
            Group{
                HStack{
                    Text("Loại sản phẩm")
                        .font(.system(size: 17).weight(.medium))
                        .expandedWidth(alignment: .leading)
                        .padding(.leading, 32)
                    
                    Picker(selection: $category, label:
                            Text("Category")){
                        ForEach(0..<categories.count){
                            Text(self.categories[$0].title).tag(categories[$0].rawValue)
                        }
                    }.padding(.trailing, 32)
                }
                        
                HStack(spacing: 10) {
                    TextField("Cấu hình", text: $key)
                        .expandedWidth()
                        .padding(.leading, 16)
                        .height(40)
                        .gradientBorder()
                    TextField("Thông số", text: $value )
                        .expandedWidth()
                        .padding(.leading, 16)
                        .height(40)
                        .gradientBorder()
                    Button {
                        ProductDetails.shared.addDetails(key: key, value: value)
                        key = ""
                        value = ""
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(Color.blue)
                            .padding(.leading)
                    }
                    
                }.padding(.horizontal, 32)
                VStack(alignment: .leading, spacing: 10){
                    Text("Thông số kĩ thuật")
                        .font(.system(size: 17).weight(.medium))
                        .expandedWidth(alignment: .leading)
                        .padding(.leading, 16)
                    let columns = Array(repeating: GridItem(alignment: .leading),
                                        count: 2)
                    LazyVGrid(columns: columns) {
                        ForEach(ProductDetails.shared.productdetails.detail.indices, id: \.self) { index in
                            let detail = ProductDetails.shared.productdetails.detail[index]
                            Text(detail.key)
                                .font(.system(size: 14).weight(.medium))
                            Text(detail.value)
                                .font(.system(size: 14))
                        }
                    }
                }
                .padding(.horizontal, 16)
                Divider().height(1)
            }
            TextField("Giá tiền", text: $price)
                .padding(.horizontal, 16)
                .height(40)
                .gradientBorder()
                .padding(.horizontal, 32)
            Spacer()
            Button {
                getimageURL { isSuccess in
                    submitAdd()
                }
            } label: {
                Text("Xác nhận")
                    .foregroundColor(.white)
                    .height(50)
                    .expandedWidth()
                    .gradientBackgound()
                    .padding(.horizontal, 16)
            }
        }
        .fullScreenCover(isPresented: $showImagePicker, onDismiss: nil) {
            ImagePickerView(image: $productimage)
                .ignoresSafeArea()
        }
    }
    
    func submitAdd() {
        viewModel.addProduct(productName: name,
                             description: description,
                             price: price,
                             company: company,
                             category: category,
                             image: image,
                             details: ProductDetails.shared.productdetails.detail){ isSuccess in
            if isSuccess {
               onAddSuccess()
                ProductDetails.shared.productdetails = .init()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    func getimageURL(completionBlock: @escaping (Bool) -> Void){
        persistImageToStorage { imageURL in
            self.imageUrl = imageURL
            self.image.append(imageURL)
            completionBlock(true)
        }
    }
    
    private func persistImageToStorage(successBlock: @escaping (String) -> Void) {
        guard let uid = BaseRequestModel.shared.auth.currentUser?.uid else { return }
        let ref = BaseRequestModel.shared.storage.reference(withPath: uid)
        guard let imageData = self.productimage?.jpegData(compressionQuality: 0.5) else { return }
        ref.putData(imageData, metadata: nil) { metadata, err in
            if let err = err {
                self.loginStatusMessage = "Failed to push image to Storage: \(err)"
                return
            }

            ref.downloadURL { url, err in
                if let err = err {
                    self.loginStatusMessage = "Failed to retrieve downloadURL: \(err)"
                    return
                }

                self.loginStatusMessage = "Successfully stored image with url: \(url?.absoluteString ?? "")"
                successBlock(url?.absoluteString ?? "")
            }
        }
    }
}


struct AddNewProductScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddNewProductScreen() {}
    }
}
