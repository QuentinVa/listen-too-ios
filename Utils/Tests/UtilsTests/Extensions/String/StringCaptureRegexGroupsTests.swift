//
//  StringCaptureRegexGroupsTests.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Testing

struct StringCaptureRegexGroupsTests {

    private let pattern = "(?<group>[a-zA-Z0-9]+)"

    @Test
    func testEmptyCapture() throws {
        // Given
        // Nothing

        // When
        let captures = try "".captureRegexGroups(
            pattern: pattern,
            namedGroups: ["group"]
        )

        // Then
        #expect(captures.isEmpty)
    }

    @Test
    func testCapture() throws {
        // Given
        // Nothing

        // When
        let captures = try "test".captureRegexGroups(
            pattern: pattern,
            namedGroups: ["group"]
        )

        // Then
        #expect(captures["group"] == "test")
    }
}
