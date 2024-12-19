//
//  StringBoldOccurrencesOfStringsTests.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Testing

struct StringBoldOccurrencesOfStringsTests {

    private let sut = "Ampoule bluetooth couleur"

    @Test
    func testBoldOccurrencesOfStringsTwoWords() {
        // Given
        let searchTerms = ["Ampoule", "couleur"]

        // When
        let result = sut.boldOccurrencesOfStrings(of: searchTerms)

        // Then
        #expect(result == "**Ampoule** bluetooth **couleur**")
    }

    @Test
    func testBoldOccurrencesOfStringsTwoWordsWithOneContainOther() {
        // Given
        let searchTerms = ["Ampoule", "le"]

        // When
        let result = sut.boldOccurrencesOfStrings(of: searchTerms)

        // Then
        #expect(result == "**Ampoule** bluetooth cou**le**ur")
    }

    @Test
    func testBoldOccurrencesOfStringsSameWord() {
        // Given
        let searchTerms = ["Amp", "oule"]

        // When
        let result = sut.boldOccurrencesOfStrings(of: searchTerms)

        // Then
        #expect(result == "**Ampoule** bluetooth c**oule**ur")
    }

    @Test
    func testBoldOccurrencesOfStringsTwoUnionWords() {
        // Given
        let sut = "Ampoule bluetooth couleur"

        // When
        let result = sut.boldOccurrencesOfStrings(of: ["poule", "Amp"])

        // Then
        #expect(result == "**Ampoule** bluetooth couleur")
    }

    @Test
    func testBoldOccurrencesOfStringsEmpty() {
        // Given
        let sut = "Ampoule bluetooth couleur"

        // When
        let result = sut.boldOccurrencesOfStrings(of: [])

        // Then
        #expect(result == "Ampoule bluetooth couleur")
    }

    @Test
    func testBoldOccurrencesOfStringsNotFound() {
        // Given
        let sut = "Ampoule bluetooth couleur"

        // When
        let result = sut.boldOccurrencesOfStrings(of: ["Lexman"])

        // Then
        #expect(result == "Ampoule bluetooth couleur")
    }
}
