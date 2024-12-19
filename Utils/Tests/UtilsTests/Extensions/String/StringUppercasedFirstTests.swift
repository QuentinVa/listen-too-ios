//
//  StringUppercasedFirstTests.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Testing

struct StringUppercasedFirstTests {

    @Test
    func testUppercasedFirstUnchanged() throws {
        // Given
        let string = "Foo-BAR"

        // When
        let result = string.uppercasedFirst

        // Then
        #expect(result == "Foo-BAR")
    }

    @Test
    func testUppercasedFirst() throws {
        // Given
        let string = "foo-BAR"

        // When
        let result = string.uppercasedFirst

        // Then
        #expect(result == "Foo-BAR")
    }
}
