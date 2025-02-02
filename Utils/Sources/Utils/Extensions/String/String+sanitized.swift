//
//  String+sanitized.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Foundation

extension String {

    /// Returns a string without leading/trailing spaces, without emojis, and in lowercase.
    public var sanitized: String {
        // Remove emojis
        let noEmojisString = self.filter { !$0.isEmoji }

        // Remove leading and trailing spaces
        let trimmedString = noEmojisString.trimmingCharacters(in: .whitespacesAndNewlines)

        // Remove diacritic
        let diacriticInsensitiveString = trimmedString.folding(options: .diacriticInsensitive, locale: .current)

        // Convert to lowercase for case-insensitive comparison
        return diacriticInsensitiveString.lowercased()
    }
}
