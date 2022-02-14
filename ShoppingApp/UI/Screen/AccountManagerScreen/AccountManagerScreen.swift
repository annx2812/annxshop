//
//  AccountManagerScreen.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 07/01/2022.
//

import SwiftUI
import SDWebImageSwiftUI
import Photos
import LottieCore

struct AccountManagerScreen: View {
    @Environment(\.rootPresentation) var rootPresenting: Binding<Bool>
    @StateObject var viewModel: AccountManagerViewModel = .init()
    @State var searchKeyWord: String = ""
    @State var showSheet: Bool = false
    @State private var selectedAccount: UserInfoObject = UserInfoObject()
    var body: some View {
        VStack {
            TextField("Tìm kiếm", text: $searchKeyWord)
                .height(40)
                .padding(.horizontal, 5)
                .gradientBorder()
                .padding(.horizontal, 16)
                .padding(.top, 5)
            List{
                Section(header: Text("Tài khoản")){
                    let accounts = viewModel.accounts.filter({searchKeyWord.isEmpty ? true : $0.email.contains(searchKeyWord)})
                    ForEach(accounts.indices, id: \.self) { index in
                        let account = accounts[index]
                        Button {
                            selectedAccount = account
                            rootPresenting.wrappedValue = true
                        } label: {
                            HStack {
                                WebImage(url: URL(string: account.imageUrl ?? ""))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(10)
                                    .clipShape(Curve())
                                Text("\(account.email ?? "")")
                                    .font(.system(size: 14).weight(.medium))
                                Spacer()
                            }
                        }
                    }
                    .onDelete { IndexSet in
                        for i in IndexSet
                        {
                            let deluser = accounts[i]
                            deleteAccount(account: deluser)
                        }
                    }
                }
            }
            .onAppear {
                viewModel.getAllAccount()
            }
            
            .navigationBarItems(
                trailing: Button("+",action: {
                    showSheet.toggle()
                })
            ).sheet(isPresented: $showSheet, content: {
                AddNewAccountScreen(){
                    showSheet = false
                }
            })
                .background(NavigationLink(isActive: rootPresenting, destination:  {DetailsAccount(account: selectedAccount)}, label: {EmptyView()}))
        }
    }
    
    func deleteAccount(account: UserInfoObject){
        AccountRequest.shared.firRef.child(account.UID ?? "").removeValue { (err, ref) in
            if err != nil {
                return
            }
        }
    }
}

struct AccountManagerScreen_Previews: PreviewProvider {
    static var previews: some View {
        AccountManagerScreen()
    }
}


