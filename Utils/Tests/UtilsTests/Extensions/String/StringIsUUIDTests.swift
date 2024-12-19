//
//  StringIsUUID.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Foundation
import Testing

struct StringIsUUIDTests {

    @Test
    func testIsValidUUID() throws {
        // Given
        let sut = UUID().uuidString

        // When
        let result = sut.isUUID

        // Then
        #expect(result)
    }

    @Test
    func testIsNotValidUUID() throws {
        // Given
        let sut = UUID().uuidString.replaceFirstOccurrence(of: "-", with: "")

        // When
        let result = sut.isUUID

        // Then
        #expect(!result)
    }
}
