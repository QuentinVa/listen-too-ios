//
//  String+uppercasedFirst.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

extension String {

    public var uppercasedFirst: String {
        let firstLetter = self.prefix(1).uppercased()
        let remainingLetters = self.dropFirst()

        return firstLetter + remainingLetters
    }
}
