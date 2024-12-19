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
        let searchTerm = "-Listen"

        // When
        let result = "App -ListenToo".boldOccurrencesOfString(of: searchTerm)

        // Then
        #expect(result == "App -**Listen**Too")
    }

    @Test
    func testBoldOccurrencesOfStringPrefixSpecialCharsString() {
        // Given
        let searchTerm = "- Listen"

        // When
        let result = "App - ListenToo".boldOccurrencesOfString(of: searchTerm)

        // Then
        #expect(result == "App - **Listen**Too")
    }

    @Test
    func testBoldOccurrencesOfStringSuffixSpecialCharString() {
        // Given
        let searchTerm = "p-"

        // When
        let result = "App- ListenToo".boldOccurrencesOfString(of: searchTerm)

        // Then
        #expect(result == "Ap**p**- ListenToo")
    }

    @Test
    func testBoldOccurrencesOfStringSuffixSpecialCharsString() {
        // Given
        let searchTerm = "p - "

        // When
        let result = "App - ListenToo".boldOccurrencesOfString(of: searchTerm)

        // Then
        #expect(result == "Ap**p** - ListenToo")
    }

    @Test
    func testBoldOccurrencesOfStringPrefixAndSuffixSpecialCharsString() {
        // Given
        let searchTerm = " - ListenToo - "

        // When
        let result = "App - ListenToo - ListenToo".boldOccurrencesOfString(of: searchTerm)

        // Then
        #expect(result == "App - **ListenToo** - ListenToo")
    }

    @Test
    func testBoldOccurrencesOfStringCaseInsensitiveString() {
        // Given
        let searchTerm = "app"

        // When
        let result = "App - ListenToo".boldOccurrencesOfString(of: searchTerm)

        // Then
        #expect(result == "**App** - ListenToo")
    }

    @Test
    func testBoldOccurrencesOfStringOnlySpecialChar() {
        // Given
        let searchTerm = "-"

        // When
        let result = "App - ListenToo".boldOccurrencesOfString(of: searchTerm)

        // Then
        #expect(result == "App - ListenToo")
    }
}
