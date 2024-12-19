//
//  StringReplaceFirstOccurrenceTests.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Testing

struct StringReplaceFirstOccurrenceTests {

    @Test
    func testReplaceFirstOccurrenceTwoOccurrences() {
        // Given
        let sut = "Replace first occurrence of toBeReplaced (this toBeReplaced must not be replaced)"

        // When
        let result = sut.replaceFirstOccurrence(of: "toBeReplaced", with: "successfullyReplaced")

        // Then
        #expect(result == "Replace first occurrence of successfullyReplaced (this toBeReplaced must not be replaced)")
    }

    @Test
    func testReplaceFirstOccurrenceNoOccurrence() {
        // Given
        let sut = "No occurrence founded"

        // When
        let result = sut.replaceFirstOccurrence(of: "toBeReplaced", with: "successfullyReplaced")

        // Then
        #expect(result == "No occurrence founded")
    }
}
