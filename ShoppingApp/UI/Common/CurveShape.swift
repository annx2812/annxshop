//
//  CurveShape.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 30/12/2021.
//

import SwiftUI

struct Curve: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addQuadCurve(to: .init(x: rect.maxX, y: rect.midY), control: .init(x: rect.maxX, y: rect.minY))
        path.addQuadCurve(to: .init(x: rect.midX, y: rect.maxY), control: .init(x: rect.maxX, y: rect.maxY))
        path.addQuadCurve(to: .init(x: rect.minX, y: rect.midY), control: .init(x: rect.minX, y: rect.maxY))
        path.addQuadCurve(to: .init(x: rect.midX, y: rect.minY), control: .init(x: rect.minX, y: rect.minY))
        return path
    }
}

struct BottomCurve: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addQuadCurve(to: .init(x: rect.midX, y: rect.maxY), control: .init(x: rect.maxX, y: rect.maxY))
        path.addQuadCurve(to: .init(x: rect.minX, y: rect.midY), control: .init(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        return path
    }
}

struct Shape_Previews: PreviewProvider {
    static var previews: some View {
        BottomCurve()
            .frame(width: 100, height: 100)
            .foregroundColor(.green)
    }
}
