//
//  View+Extensions.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 30/12/2021.
//

import Foundation
import SwiftUI

extension View {
    func expanded(alignment: Alignment? = nil) -> some View {
        self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment ?? .center)
    }
    func expandedWidth(alignment: Alignment? = nil) -> some View {
        self.frame(maxWidth: .infinity, alignment: alignment ?? .center)
    }
    func expandedHeight(alignment: Alignment? = nil) -> some View {
        self.frame(maxHeight: .infinity, alignment: alignment ?? .center)
    }
    func width(_ width: CGFloat) -> some View {
        self.frame(width: width)
    }
    func height(_ height: CGFloat) -> some View {
        self.frame(height: height)
    }
    
    func gradientForeground() -> some View {
        self.overlay(LinearGradient(gradient: .init(colors: [.blue, .green]),
                                            startPoint: .leading,
                                            endPoint: .trailing))
                    .mask(self)
    }
    
    func gradientBorder() -> some View {
        self.overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(LinearGradient(gradient: .init(colors: [.blue, .green]),
                                       startPoint: .leading,
                                       endPoint: .trailing),
                        lineWidth: 1.5)
        )
    }
    
    func gradientBackgound() -> some View {
        self.background(
            RoundedRectangle(cornerRadius: 10)
                .gradientForeground()
        )
    }
    
    func border() -> some View {
        self.overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1.5)
                .foregroundColor(.gray.opacity(0.5))
        )
    }
    
    func addNavigationBar(title: String, isHiddenBackButton: Bool = false, isHiddenCart: Bool = false) -> some View {
        BaseNavigationView(title: title, isHiddenBackButton: isHiddenBackButton, isHiddenCart: isHiddenCart ) {
            self
        }.modifier(HideNavModifier())
    }
}

extension Image {
    func gradientForeground() -> some View {
        self.overlay(LinearGradient(gradient: .init(colors: [.blue, .green]),
                                    startPoint: .leading,
                                            endPoint: .trailing))
            .mask(self.renderingMode(.template))
    }
}
