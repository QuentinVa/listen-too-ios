//
//  DataToDictionaryTests.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Foundation
import Testing

// swiftlint:disable no_magic_numbers

struct DataToDictionaryTests {

    @Test
    func testDataToDictionary() throws {
        // Given
        let values = [
            "firstKey": 1,
            "secondKey": 2
        ]
        let data = try JSONEncoder().encode(values)

        // When
        let dictionary = try #require(data.toDictionary as? [String: Int])

        // Then
        #expect(dictionary == values)
    }
}
