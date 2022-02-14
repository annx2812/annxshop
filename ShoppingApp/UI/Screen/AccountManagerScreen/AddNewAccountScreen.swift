//
//  AddNewAccountScreen.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 11/01/2022.
//

import SwiftUI
import PhotosUI

struct AddNewAccountScreen: View {
    @StateObject var viewModel: AccountManagerViewModel = .init()
    @State var showImagePicker = false
    @State var image: UIImage?
    @State var email: String = ""
    @State var password: String = ""
    @State var name: String = ""
    @State var imageUrl: String = ""
    @State var birthday: String = ""
    @State var phone: String = ""
    @State var isAdmin = false
    @State var listgender : [String] = ["Male","Female"]
    @State var gender : String = ""
    @State var loginStatusMessage = ""
    var onAddSuccess: ()-> Void
    
    var body: some View {
        NavigationView{
            VStack{
                Button {
                    showImagePicker.toggle()
                } label: {
                    if let image = self.image {
                        Image(uiImage: image)
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
        }
        .navigationTitle("Create Account")
        .fullScreenCover(isPresented: $showImagePicker, onDismiss: nil) {
            ImagePickerView(image: $image)
                .ignoresSafeArea()
        }
    }
    
    func submitAdd() {
        viewModel.signUp(userName: name,
                         email: email,
                         password: password,
                         imageUrl: imageUrl,
                         birthDay: birthday,
                         phoneNumber: phone,
                         isAdmin: isAdmin,
                         gender: gender) { isSuccess in
            if isSuccess {
               onAddSuccess()
            }
           
        }
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

struct AddNewAccountScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddNewAccountScreen(){}
    }
}


