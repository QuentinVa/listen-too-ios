//
//  StringToDictionaryTests.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Testing

// swiftlint:disable force_cast
// swiftlint:disable force_unwrapping

struct StringToDictionaryTests {

    @Test
    func testToDictionaryWithEmptyString() throws {
        // Given
        let string = ""

        // When
        let result = string.toDictionary

        // Then
        #expect(result == nil)
    }

    @Test
    func testToDictionaryWithWrongString() throws {
        // Given
        let string = "aaa"

        // When
        let result = string.toDictionary

        // Then
        #expect(result == nil)
    }

    @Test
    func testToDictionary() throws {
        // Given
        let string = "{\"foo\":\"bar\"}"

        // When
        let result = string.toDictionary

        // Then
        #expect(result!["foo"] as! String == "bar")
    }
}
