//
//  CharacterIsEmojiTests.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Testing

struct CharacterIsEmojiTests {

    @Test
    func testIsEmoji() {
        // Given
        let emojis: [Character] = ["😀", "🐶", "🍏", "⚽️", "🚗", "⌚️"]

        emojis.forEach { emoji in
            #expect(emoji.isEmoji)
        }

        let nonEmojis: [Character] = ["a", "1", "!", "`", "€", "+", "#", "\\"]

        nonEmojis.forEach { nonEmoji in
            #expect(nonEmoji.isEmoji == false)
        }
    }
}
