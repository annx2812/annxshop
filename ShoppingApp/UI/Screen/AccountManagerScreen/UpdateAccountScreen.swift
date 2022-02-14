//
//  UpdateAccountScreen.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 11/01/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct UpdateAccountScreen: View {
    @Environment(\.rootPresentation) var rootPresentation: Binding<Bool>
    @StateObject var viewModel: AccountManagerViewModel = .init()
    @State var account : UserInfoObject
    @State var showImagePicker = false
    @State var image: UIImage?
    @State var loginStatusMessage = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var name: String = ""
    @State var imageUrl: String = ""
    @State var birthday: String = ""
    @State var phone: String = ""
    @State var isAdmin = false
    @State var listgender : [String] = ["Male","Female"]
    @State var gender : String = ""
    //var onUpdateSuccess: ()-> Void
    var body: some View {
            VStack{
                Button {
                    showImagePicker.toggle()
                } label: {
                    if image != nil{
                        if let image = self.image{
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 128, height: 128)
                                .cornerRadius(64)
                        }
                    }
                    else {
                        WebImage(url: URL(string: account.imageUrl ?? ""))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                            .clipShape(Curve())
                    }
                    
                }
                Group{
                    TextField("Email", text: $email)
                        .padding(.horizontal, 16)
                        .height(40)
                        .gradientBorder()
                        .padding(.horizontal, 32)
                    TextField("Password", text: $password)
                        .padding(.horizontal, 16)
                        .height(40)
                        .gradientBorder()
                        .padding(.horizontal, 32)
                    TextField("Name", text: $name)
                        .padding(.horizontal, 16)
                        .height(40)
                        .gradientBorder()
                        .padding(.horizontal, 32)
                    HStack{
                        Text("Gender")
                            .font(.system(size: 17).weight(.medium))
                            .expandedWidth(alignment: .leading)
                            .padding(.leading, 32)
                        
                        Picker(selection: $gender, label:
                                Text("Gender")){
                            ForEach(listgender.indices, id: \.self){ index in
                                Text(listgender[index]).tag(listgender[index])
                            }
                        }.padding(.trailing, 32)
                    }
                    TextField("Birth Day", text: $birthday)
                        .padding(.horizontal, 16)
                        .height(40)
                        .gradientBorder()
                        .padding(.horizontal, 32)
                    TextField("Phone Number", text: $phone)
                        .padding(.horizontal, 16)
                        .height(40)
                        .gradientBorder()
                        .padding(.horizontal, 32)
                }
                HStack{
                    Text("Permission")
                        .font(.system(size: 17).weight(.medium))
                        .expandedWidth(alignment: .leading)
                        .padding(.leading, 32)
                    
                    Picker(selection: $isAdmin, label:
                            Text("Permission")){
                        Text("Admin").tag(true)
                        Text("User").tag(false)
                    }.padding(.trailing, 32)
                }
                Spacer()
                Button (action: {
                    if image == nil{
                        submitAdd()  { _ in
                            rootPresentation.wrappedValue = false
                        }
                    }
                    else {
                        getimageURL { isSuccess in
                            submitAdd() { _ in
                                rootPresentation.wrappedValue = false
                            }
                        }
                    }
                    
                }, label: {
                    Text("Xác nhận")
                        .foregroundColor(.white)
                        .height(50)
                        .expandedWidth()
                        .gradientBackgound()
                        .padding(.horizontal, 16)
                })
            }
            .onAppear {
                email = account.email ?? ""
                name = account.userName ?? ""
                imageUrl = account.imageUrl ?? ""
                birthday = account.birthDay ?? ""
                phone = account.phone_number ?? ""
                
            }
            .fullScreenCover(isPresented: $showImagePicker, onDismiss: nil) {
                ImagePickerView(image: $image)
                    .ignoresSafeArea()
            }
        .addNavigationBar(title: "Update Account",isHiddenCart: true)
    }
    
    func submitAdd(completionBlock: @escaping (Bool) -> Void) {
        viewModel.updateAccount(userName: name,
                                UID: account.UID,
                             email: email,
                             imageUrl: imageUrl,
                             birthDay: birthday,
                             phoneNumber: phone,
                             isAdmin: isAdmin,
                             gender: gender, completionBlock: completionBlock)
    }
    
    func getimageURL(completionBlock: @escaping (Bool) -> Void){
        persistImageToStorage { imageURL in
            self.imageUrl = imageURL
            completionBlock(true)
        }
    }
    
    private func persistImageToStorage(successBlock: @escaping (String) -> Void) {
        guard let uid = BaseRequestModel.shared.auth.currentUser?.uid else { return }
        let ref = BaseRequestModel.shared.storage.reference(withPath: uid)
        guard let imageData = self.image?.jpegData(compressionQuality: 0.5) else { return }
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

struct UpdateAccountScreen_Previews: PreviewProvider {
    static var previews: some View {
        UpdateAccountScreen(account: UserInfoObject())
    }
}
