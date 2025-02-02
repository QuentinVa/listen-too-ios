//
//  StringIsNullOrEmptyTests.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Testing

struct StringIsNullOrEmptyTests {

    private let pattern = "(?<group>[a-zA-Z0-9]+)"

    @Test
    func testIsNullOrEmptyOnEmptyString() throws {
        // Given
        let string: String? = ""

        // When
        let isNullOrEmpty = string.isNullOrEmpty

        // Then
        #expect(isNullOrEmpty)
    }

    @Test
    func testIsNullOrEmptyOnNilString() throws {
        // Given
        let string: String? = nil

        // When
        let isNullOrEmpty = string.isNullOrEmpty

        // Then
        #expect(isNullOrEmpty)
    }

    @Test
    func testIsNullOrEmptyOnNotNilAndNotEmptyString() throws {
        // Given
        let string: String? = "Example"

        // When
        let isNullOrEmpty = string.isNullOrEmpty

        // Then
        #expect(!isNullOrEmpty)
    }
}
