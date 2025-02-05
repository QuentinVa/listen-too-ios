//
//  ComponentsView.swift
//  App iOS
//
//  Created by Quentin Varlet on 02/03/2023.
//

import SwiftUI
import ListenTooDesignSystem

struct ComponentsView: View {

    // MARK: Properties

    @State var binding: Bool = false

    // MARK: View

   var body: some View {
       NavigationView {
           VStack {
               ListenTooText(
                    "Liste de buttons",
                    font: .bodyLargeHighlight,
                    foregroundColor: .status(.danger)
               )

               ListenTooButton(
                    text: "ListenTooButton",
                    theme: .primary,
                    width: .fill,
                    isLoading: $binding
               ) {}

               ListenTooButton(
                    text: "Secondary",
                    theme: .secondary,
                    width: .fill
               ) {}
           }
           .listenTooPadding(.mu100)
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
