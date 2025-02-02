//
//  String+lowercasedFirst.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

extension String {

    public var lowercasedFirst: String {
        let firstLetter = self.prefix(1).lowercased()
        let remainingLetters = self.dropFirst()

        return firstLetter + remainingLetters
    }
}
