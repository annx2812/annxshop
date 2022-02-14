//
//  CustomEnvironmentView.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 17/01/2022.
//

import Foundation
import SwiftUI

struct RootPresentationKey: EnvironmentKey{
    static var defaultValue: Binding<Bool> = .constant(false)
}

extension EnvironmentValues{
    var rootPresentation: Binding<Bool>{
        get{
            self[RootPresentationKey.self]
        }
        set {
            self[RootPresentationKey.self] = newValue
        }
    }
}
