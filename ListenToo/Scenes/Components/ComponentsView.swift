//
//  ComponentsView.swift
//  App iOS
//
//  Created by Quentin Varlet on 02/03/2023.
//

import SwiftUI

struct ComponentsView: View {

    // MARK: View

   var body: some View {
       NavigationView {
           VStack {
               PrimaryButton(title: "Primary Button") {}
               SecondaryButton(title: "Secondary Button") {}
           }
           .padding(LTDesignSystem.MagicUnit.mu016.rawValue)
           .navigationTitle("ComponentsView")
       }
   }
}

// MARK: Preview

#if DEBUG

struct ComponentsView_Previews: PreviewProvider {
    static var previews: some View {
        ComponentsView()
    }
}

#endif
