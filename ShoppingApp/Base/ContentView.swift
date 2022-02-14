//
//  ContentView.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 30/12/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var rootPresenting : Bool = false
    var body: some View {
        NavigationView {
            HomeScreen()
                .modifier(HideNavModifier())
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .environment(\.rootPresentation, $rootPresenting)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct HideNavModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
    }
}
