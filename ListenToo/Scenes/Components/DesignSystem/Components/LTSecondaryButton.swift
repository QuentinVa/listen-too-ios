//
//  LTSecondaryButton.swift
//  ListenToo
//
//  Created by Quentin Varlet on 02/02/2025.
//

import SwiftUI

struct SecondaryButton: View {

    // MARK: Properties

    let title: String
    let action: () -> Void

    // MARK: View

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(LTDesignSystem.Typography.body)
                .foregroundColor(LTDesignSystem.ForegroundColors.secondary)
                .padding()
                .frame(maxWidth: .infinity)
                .background(LTDesignSystem.Colors.secondary)
                .cornerRadius(LTDesignSystem.MagicUnit.mu012.rawValue)
        }
    }
}

// MARK: Preview

#if DEBUG

struct SecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryButton(title: "Secondary Button") {}
            .padding(10)
    }
}

#endif

