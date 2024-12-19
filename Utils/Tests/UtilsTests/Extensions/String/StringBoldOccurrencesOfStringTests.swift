//
//  StringBoldOccurrencesOfStringTests.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Testing

struct StringBoldOccurrencesOfStringTests {

    private let sut = "Replace first occurrence of toBeReplaced (this toBeReplaced must be replaced)"

    @Test
    func testBoldOccurrencesOfStringTwoOccurrences() {
        // Given
        let searchTerm = "toBeReplaced"

        // When
        let result = sut.boldOccurrencesOfString(of: searchTerm)

        // Then
        #expect(result == "Replace first occurrence of **toBeReplaced** (this **toBeReplaced** must be replaced)")
    }

    @Test
    func testBoldOccurrencesOfStringNoOccurrence() {
        // Given
        let searchTerm = "toBeReplaced"

        // When
        let result = "No occurrence founded".boldOccurrencesOfString(of: searchTerm)

        // Then
        #expect(result == "No occurrence founded")
    }

    @Test
    func testBoldOccurrencesOfStringCaseInsensitive() {
        // Given
        let searchTerm = "toBeReplaced"

        // When
        let result = sut.boldOccurrencesOfString(of: searchTerm)

        // Then
        #expect(result == "Replace first occurrence of **toBeReplaced** (this **toBeReplaced** must be replaced)")
    }

    @Test
    func testBoldOccurrencesOfStringEmptyString() {
        // Given
        let emptyString = ""
        let searchTerm = "toBeReplaced"

        // When
        let result = emptyString.boldOccurrencesOfString(of: searchTerm)

        // Then
        #expect(result.isEmpty)
    }

    @Test
    func testBoldOccurrencesOfStringNoMatch() {
        // Given
        let searchTerm = "toBeReplaced"

        // When
        let result = "This string has no match".boldOccurrencesOfString(of: searchTerm)

        // Then
        #expect(result == "This string has no match")
    }

    @Test
    func testBoldOccurrencesOfStringPrefixSpecialCharString() {
        // Given
        let searchTerm = "-En"

        // When
        let result = "Box -Enki".boldOccurrencesOfString(of: searchTerm)

        // Then
        #expect(result == "Box -**En**ki")
    }

    @Test
    func testBoldOccurrencesOfStringPrefixSpecialCharsString() {
        // Given
        let searchTerm = "- En"

        // When
        let result = "Box - Enki".boldOccurrencesOfString(of: searchTerm)

        // Then
        #expect(result == "Box - **En**ki")
    }

    @Test
    func testBoldOccurrencesOfStringSuffixSpecialCharString() {
        // Given
        let searchTerm = "x-"

        // When
        let result = "Box- Enki".boldOccurrencesOfString(of: searchTerm)

        // Then
        #expect(result == "Bo**x**- Enki")
    }

    @Test
    func testBoldOccurrencesOfStringSuffixSpecialCharsString() {
        // Given
        let searchTerm = "x - "

        // When
        let result = "Box - Enki".boldOccurrencesOfString(of: searchTerm)

        // Then
        #expect(result == "Bo**x** - Enki")
    }

    @Test
    func testBoldOccurrencesOfStringPrefixAndSuffixSpecialCharsString() {
        // Given
        let searchTerm = " - Enki - "

        // When
        let result = "Box - Enki - Enki".boldOccurrencesOfString(of: searchTerm)

        // Then
        #expect(result == "Box - **Enki** - Enki")
    }

    @Test
    func testBoldOccurrencesOfStringCaseInsensitiveString() {
        // Given
        let searchTerm = "box"

        // When
        let result = "Box - Enki".boldOccurrencesOfString(of: searchTerm)

        // Then
        #expect(result == "**Box** - Enki")
    }

    @Test
    func testBoldOccurrencesOfStringOnlySpecialChar() {
        // Given
        let searchTerm = "-"

        // When
        let result = "Box - Enki".boldOccurrencesOfString(of: searchTerm)

        // Then
        #expect(result == "Box - Enki")
    }
}
