//
//  HomeScreen.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 30/12/2021.
//

import SwiftUI
import LottieCore

struct HomeScreen: View {
    var tabs: [HomeTab] = HomeTab.allCases
    @State var currentTab = 0
    var body: some View {
        VStack {
            TabView(selection: $currentTab) {
                CategoryScreen()
                    .tag(0)
                UserScreen()
                    .tag(1)
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .animation(.none)
                .background(
                    LinearGradient(colors: [.blue, .green],
                                               startPoint: .leading,
                                               endPoint: .trailing)
                                    .ignoresSafeArea()
                        .height(0)
                        .expandedHeight(alignment: .top)
                )
            HStack{
                ForEach(tabs.indices, id: \.self) { index in
                    tabs[index].icon
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 20, height: 20)
                        .frame(width: 40, height: 40)
                        .background(Color.white.opacity(currentTab == index ? 1 : 0.3))
                        .foregroundColor(currentTab == index ? .blue : .white)
                        .clipShape(Curve())
                        .expandedWidth()
                        .onTapGesture {
                            currentTab = index
                        }
                }
            }
            .padding(.horizontal, 60)
            .height(60)
            .background(LinearGradient(colors: [.blue, .green],
                                       startPoint: .leading,
                                       endPoint: .trailing)
                            .ignoresSafeArea())
            .modifier(HideNavModifier())
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
