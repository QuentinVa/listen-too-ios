//
//  LTPrimaryButton.swift
//  ListenToo
//
//  Created by Quentin Varlet on 02/02/2025.
//

import SwiftUI

struct PrimaryButton: View {

    // MARK: Properties

    let title: String
    let action: () -> Void

    // MARK: View

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(LTDesignSystem.Typography.body)
                .foregroundColor(LTDesignSystem.ForegroundColors.primary)
                .padding()
                .frame(maxWidth: .infinity)
                .background(LTDesignSystem.Colors.primary)
                .cornerRadius(LTDesignSystem.MagicUnit.mu012.rawValue)
        }
    }
}

// MARK: Preview

#if DEBUG

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(title: "Primary Button") {}
            .padding()
    }
}

#endif
