//
//  StringIsRegexValidTests.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Testing

struct StringIsRegexValidTests {

    @Test
    func testIsRegexValidShouldSucceed() throws {
        // Given
        let sut = "Ceci est un test"

        // When
        let result = sut.isRegexValid(pattern: "est un")

        // Then
        #expect(result)
    }

    @Test
    func testIsRegexValidShouldFail() throws {
        // Given
        let sut = "Ceci est un test"

        // When
        let result = sut.isRegexValid(pattern: "toto")

        // Then
        #expect(!result)
    }

    @Test
    func testIsRegexValidShouldFailDueToInvalidPattern() throws {
        // Given
        let sut = "Ceci est un test"

        // When
        let result = sut.isRegexValid(pattern: "[unmatched parentheses")

        // Then
        #expect(!result)
    }
}
