//
//  String+.swift
//  Utils
//
//  Created by Quentin Varlet on 19/12/2024.
//

public import Foundation

extension String {

    public func removingCharacters(from set: CharacterSet) -> String {
        var newString = self
        newString.removeAll { char -> Bool in
            guard let scalar = char.unicodeScalars.first else { return false }
            return set.contains(scalar)
        }
        return newString
    }
}
