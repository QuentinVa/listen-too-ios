//
//  StringIsNotEmptyTests.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Testing

struct StringIsNotEmptyTests {

    @Test
    func testStringEmpty() {
        // Given
        let value = ""

        // When
        let result = value.isNotEmpty

        // Then
        #expect(!result)
    }

    @Test
    func testStringNotEmpty() {
        // Given
        let value = "some"

        // When
        let result = value.isNotEmpty

        // Then
        #expect(result)
    }
}
