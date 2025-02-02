//
//  String+SpecialChar.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Foundation

extension String {

    public var isFirstCharacterSpecial: Bool {
        guard let firstCharacter = self.first else { return false }
        return isCharSpecial(firstCharacter)
    }

    public var isLastCharacterSpecial: Bool {
        guard let lastCharacter = self.last else { return false }
        return isCharSpecial(lastCharacter)
    }

    public func isCharSpecial(_ char: Element) -> Bool {
        let specialCharacterSet = CharacterSet.punctuationCharacters
            .union(.symbols)
            .union(.whitespaces)
        return String(char).rangeOfCharacter(from: specialCharacterSet) != nil
    }
}
