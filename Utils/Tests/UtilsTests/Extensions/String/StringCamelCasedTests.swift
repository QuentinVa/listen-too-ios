//
//  StringCamelCasedTests.swift
//  Utils
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Testing

struct StringCamelCasedTests {

    @Test
    func snakeCasedStringToCamelCasedString() {
        // Given
        let sut = "an_example_of_string"

        // When
        let result = sut.camelCased()

        // Then
        #expect(result == "anExampleOfString")
    }

    @Test
    func stringWithUppercasedFirstWordsToCamelCasedString() {
        // Given
        let sut = "An Example Of String"

        // When
        let result = sut.camelCased()

        // Then
        #expect(result == "anExampleOfString")
    }

    @Test
    func stringWithLowercasedWordsToCamelCasedString() {
        // Given
        let sut = "an example of string"

        // When
        let result = sut.camelCased()

        // Then
        #expect(result == "anExampleOfString")
    }
}
