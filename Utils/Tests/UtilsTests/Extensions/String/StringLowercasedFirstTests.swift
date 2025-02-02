//
//  StringLowercasedFirstTests.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Testing

struct StringLowercasedFirstTests {

    @Test
    func testLowercasedFirst() throws {
        // Given
        let string = "Foo-BAR"

        // When
        let result = string.lowercasedFirst

        // Then
        #expect(result == "foo-BAR")
    }
}
