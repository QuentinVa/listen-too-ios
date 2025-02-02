//
//  StringMaskSuffixTests.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Testing

// swiftlint:disable no_magic_numbers

struct StringMaskSuffixTests {

    @Test
    func testStringMaskSuffix() throws {
        // Given
        let sut = "123456789"

        // When
        let result = sut.maskSuffix(keep: 4)

        // Then
        #expect(result == "1234*****")
    }

    @Test
    func testStringMaskSuffixIfNumberOfCharsGreaterThanLimit() throws {
        // Given
        let sut = "123456789"

        // When
        let result = sut.maskSuffix(keep: 999)

        // Then
        #expect(result == "123456789")
    }

    @Test
    func testStringMaskSuffixIfNumberOfCharsLowerThan0() throws {
        // Given
        let sut = "123456789"

        // When
        let result = sut.maskSuffix(keep: -1)

        // Then
        #expect(result == "*********")
    }
}
