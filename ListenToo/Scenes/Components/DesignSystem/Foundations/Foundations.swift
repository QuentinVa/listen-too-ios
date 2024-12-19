//
//  Foundations.swift
//  ListenToo
//
//  Created by Quentin Varlet on 02/02/2025.
//

import SwiftUI

struct LTDesignSystem {

    struct Colors {

        static let primary = Color.blue
        static let secondary = Color.gray
        static let error = Color.red
    }

    struct ForegroundColors {

        static let primary = Color.white
        static let secondary = Color.black
    }

    struct Typography {

        static let title = Font.system(size: 24, weight: .bold)
        static let body = Font.system(size: 16, weight: .regular)
        static let caption = Font.system(size: 12, weight: .light)
    }

    enum MagicUnit: CGFloat, CaseIterable {

        case zero = 0
        case mu004 = 4
        case mu008 = 8
        case mu012 = 12
        case mu016 = 16
        case mu020 = 20
        case mu024 = 24
        case mu028 = 28
        case mu032 = 32
        case mu064 = 64
        case mu128 = 128
    }
}
