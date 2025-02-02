//
//  DataBase64URLEncodedStringTests.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Foundation
import Testing

// swiftlint:disable no_magic_numbers

struct DataBase64URLEncodedStringTests {

    @Test
    func testBase64EncodedString() throws {
        // Given
        let bytes: [UInt8] = [
            252, 081, 174, 136, 185, 025, 117, 176,
            182, 084, 104, 145, 173, 139, 095, 110,
            110, 197, 229, 098, 055, 223, 238, 083,
            163, 132, 235, 117, 116, 154, 034, 070
        ]

        // When
        let result = Data(bytes: bytes, count: bytes.count).base64URLEncodedString

        // Then
        #expect(result.isEmpty == false)
        #expect(result.contains("=") == false)
        #expect(result.contains("+") == false)
        #expect(result.contains("/") == false)
        #expect(result.whitespacesTrimmed.isEmpty == false)
        #expect(result == "_FGuiLkZdbC2VGiRrYtfbm7F5WI33-5To4TrdXSaIkY")
    }
}
