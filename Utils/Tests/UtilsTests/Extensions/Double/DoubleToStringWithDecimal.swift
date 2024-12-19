//
//  DoubleToStringWithDecimal.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Foundation
import Testing

struct DoubleToStringWithDecimal {

    @Test
    func testFormatValueWithNoDecimal() throws {
        // Given
        let double = 10.0

        // When
        let result = double.toStringWithDecimal

        // Then
        #expect(result == "10.0")
    }

    @Test
    func testFormatValueWithOneDecimal() throws {
        // Given
        let double = 10.5

        // When
        let result = double.toStringWithDecimal

        // Then
        #expect(result == "10.5")
    }

    @Test
    func testFormatValueWithFiveDecimal() throws {
        // Given
        let double = 10.12345

        // When
        let result = double.toStringWithDecimal

        // Then
        #expect(result == "10.1")
    }
}
