//
//  StringKebabCasedTests.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Testing

struct StringKebabCasedTests {

    @Test
    func testCamelCasedStringToKebabCasedString() {
        // Given
        let sut = "AnExampleOfCamelCasedString"

        // When
        let result = sut.kebabCased()

        // Then
        #expect(result == "an-example-of-camel-cased-string")
    }

    @Test
    func testStringWithUppercasedWordsToKebabCasedString() {
        // Given
        let sut = "An Example Of String"

        // When
        let result = sut.kebabCased()

        // Then
        #expect(result == "an-example-of-string")
    }

    @Test
    func testStringAlreadyKebabCasedToKebabCasedString() {
        // Given
        let sut = "an-example-of-string"

        // When
        let result = sut.kebabCased()

        // Then
        #expect(result == "an-example-of-string")
    }
}
