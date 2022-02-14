//
//  UpdateUserScreen.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 13/01/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct UpdateUserScreen: View {
    @StateObject var viewModel: AccountManagerViewModel = .init()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var account : UserInfoObject
    @State var showImagePicker = false
    @State var image: UIImage?
    @State var email: String = ""
    @State var name: String = ""
    @State var imageUrl: String = ""
    @State var birthday: String = ""
    @State var phone: String = ""
    @State var listgender : [String] = ["Male","Female"]
    @State var gender : String = ""
    @State var loginStatusMessage = ""
    var onUpdateSuccess: ()-> Void
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Text("Ảnh đại diện:")
                .font(.system(size: 14).weight(.medium))
            Button {
                showImagePicker.toggle()
            } label: {
                if image != nil{
                    if let image = self.image{
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .expandedWidth()
                            .frame(width: 128, height: 128)
                            .cornerRadius(64)
                    }
                }
                else if UserInfo.shared.currentUser?.imageUrl == ""{
                    Image("ic_user")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .expandedWidth()
                        .gradientBackgound()
                        .clipShape(Circle())
                }
                else {
                    WebImage(url: URL(string: UserInfo.shared.currentUser?.imageUrl ?? ""))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .expandedWidth()
                        .cornerRadius(10)
                        .clipShape(Curve())
                }
            }
            Group{
                Text("Email:")
                    .font(.system(size: 14).weight(.medium))
                TextField("Email", text: $email)
                    .padding(.horizontal, 16)
                    .height(40)
                    .gradientBorder()
                    .padding(.horizontal, 32)
                Text("Họ và tên:")
                    .font(.system(size: 14).weight(.medium))
                TextField("Name", text: $name)
                    .padding(.horizontal, 16)
                    .height(40)
                    .gradientBorder()
                    .padding(.horizontal, 32)
                HStack{
                    Text("Giới tính:")
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
                Text("Ngày sinh:")
                    .font(.system(size: 14).weight(.medium))
                TextField("Birth Day", text: $birthday)
                    .padding(.horizontal, 16)
                    .height(40)
                    .gradientBorder()
                    .padding(.horizontal, 32)
                Text("Số điện thoại:")
                    .font(.system(size: 14).weight(.medium))
                TextField("Phone Number", text: $phone)
                    .padding(.horizontal, 16)
                    .height(40)
                    .gradientBorder()
                    .padding(.horizontal, 32)
            }
            Spacer()
            Button {
                if image == nil{
                    submitAdd()
                }
                else {
                    getimageURL { isSuccess in
                        submitAdd()
                    }
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
        .onAppear {
            email = UserInfo.shared.currentUser?.email ?? ""
            name = UserInfo.shared.currentUser?.userName ?? ""
            imageUrl = UserInfo.shared.currentUser?.imageUrl ?? ""
            birthday = UserInfo.shared.currentUser?.birthDay ?? ""
            phone = UserInfo.shared.currentUser?.phone_number ?? ""
        }
        .fullScreenCover(isPresented: $showImagePicker, onDismiss: nil) {
            ImagePickerView(image: $image)
                .ignoresSafeArea()
        }.padding(.horizontal, 16)
    .addNavigationBar(title: "Update Account",isHiddenCart: true)
    }
    
    func submitAdd() {
        viewModel.updateAccount(userName: name,
                                UID: UserInfo.shared.getUID(),
                             email: email,
                             imageUrl: imageUrl,
                             birthDay: birthday,
                             phoneNumber: phone,
                                isAdmin: account.isAdmin,
                             gender: gender) { isSuccess in
            if isSuccess {
               onUpdateSuccess()
                BaseRequestModel.shared.getCurrentUserInfo()
                presentationMode.wrappedValue.dismiss()
                
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

struct UpdateUserScreen_Previews: PreviewProvider {
    static var previews: some View {
        UpdateUserScreen(account: UserInfoObject()){}
    }
}
