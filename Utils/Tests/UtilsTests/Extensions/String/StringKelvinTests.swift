//
//  StringKelvinTests.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Testing

// swiftlint:disable no_magic_numbers

struct StringKelvinTests {

    @Test
    func testExtractKelvinValue() {
        let kelvinString = "T2200K"
        #expect(2_200.0 == kelvinString.toKelvinValue)
    }

    @Test
    func testExtractKelvinValueInMalformedString() {
        let kelvinString = "foo"
        #expect(kelvinString.toKelvinValue == nil)
    }
}
