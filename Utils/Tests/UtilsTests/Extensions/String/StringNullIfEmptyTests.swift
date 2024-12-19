//
//  StringNullIfEmptyTests.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Testing

struct StringNullIfEmptyTests {

    @Test
    func testEmpty() {
        // Given
        let emptyString = ""

        // When
        let expectedString = emptyString.nullIfEmpty

        // Then
        #expect(expectedString == nil)
    }

    @Test
    func testOptionalEmpty() {
        // Given
        let emptyString: String? = ""

        // When
        let expectedString = emptyString.nullIfEmpty

        // Then
        #expect(expectedString == nil)
    }

    @Test
    func testNonEmpty() {
        // Given
        let nonEmptyString = "nonEmpty"

        // When
        let expectedString = nonEmptyString.nullIfEmpty

        // Then
        #expect(expectedString == nonEmptyString)
    }
}
