//
//  StringWhitespacesTrimmedTests.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Testing

// swiftlint:disable indentation_width

struct StringWhitespacesTrimmedTests {

    @Test
    func testGoodWhitespacesTrimmed() throws {
        // Given
        let string1 = "foo@bar.com "
        let string2 = " foo@bar.com"
        let string3 = " foo@bar.com "

        // When
        let result1 = string1.whitespacesTrimmed
        let result2 = string2.whitespacesTrimmed
        let result3 = string3.whitespacesTrimmed

        // Then
        #expect(result1 == "foo@bar.com")
        #expect(result2 == "foo@bar.com")
        #expect(result3 == "foo@bar.com")
    }

    @Test
    func testGoodwhitespacesAndNewlinesTrimmed() throws {
        // Given
        let string1 = """
              foo@bar.com
        """
        let string2 = """
        foo@bar.com

        """
        let string3 = """


        foo@bar.com

        """

        // When
        let result1 = string1.whitespacesAndNewlinesTrimmed
        let result2 = string2.whitespacesAndNewlinesTrimmed
        let result3 = string3.whitespacesAndNewlinesTrimmed

        // Then
        #expect(result1 == "foo@bar.com")
        #expect(result2 == "foo@bar.com")
        #expect(result3 == "foo@bar.com")
    }
}
