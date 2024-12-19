//
//  StringSanitizedTests.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Testing

struct StringSanitizedTests {

    @Test
    func testSanitized() {
        // Given
        let string = """

            😀  🐶  🍏  foo ⚽️  🚗  ⌚️

        """

        #expect(string.sanitized == "foo")
    }
}
