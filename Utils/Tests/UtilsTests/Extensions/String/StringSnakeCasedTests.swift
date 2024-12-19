//
//  StringSnakeCasedTests.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Testing

struct StringSnakeCasedTests {

    @Test
    func testCamelCasedStringToSnakeCasedString() {
        // Given
        let sut = "AnExampleOfCamelCasedString"

        // When
        let result = sut.snakeCased()

        // Then
        #expect(result == "an_example_of_camel_cased_string")
    }

    @Test
    func testStringWithUppercasedWordsToSnakeCasedString() {
        // Given
        let sut = "An Example Of String"

        // When
        let result = sut.snakeCased()

        // Then
        #expect(result == "an_example_of_string")
    }

    @Test
    func testStringAlreadySnakeCasedToSnakeCasedString() {
        // Given
        let sut = "an_example_of_string"

        // When
        let result = sut.snakeCased()

        // Then
        #expect(result == "an_example_of_string")
    }
}
