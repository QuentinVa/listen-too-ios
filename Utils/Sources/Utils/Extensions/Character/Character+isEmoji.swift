//
//  Character+isEmoji.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Foundation

extension Character {

    public var isEmoji: Bool {
        guard let scalar = unicodeScalars.first else { return false }

        return scalar.properties.isEmoji
            && (scalar.value >= 0x203C || unicodeScalars.count > 1) // swiftlint:disable:this no_magic_numbers
    }
}
