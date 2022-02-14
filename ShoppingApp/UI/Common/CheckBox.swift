//
//  CheckBox.swift
//  ShoppingApp
//
//  Created by Nguyễn Hoàng on 02/01/2022.
//

import SwiftUI

struct CheckBox: View {
    @Binding var checked: Bool

      var body: some View {
          Image(systemName: checked ? "checkmark.square.fill" : "square")
              .foregroundColor(checked ? Color(UIColor.systemBlue) : Color.secondary)
              .onTapGesture {
                  self.checked.toggle()
              }
      }
  }

  struct CheckBoxView_Previews: PreviewProvider {
      struct CheckBoxViewHolder: View {
          @State var checked = false

          var body: some View {
              CheckBox(checked: $checked)
          }
      }

      static var previews: some View {
          CheckBoxViewHolder()
      }
  }
