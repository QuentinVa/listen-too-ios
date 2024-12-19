//
//  BuildConfigurationTests.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Testing
@testable import Utils

struct BuildConfigurationTests {

    @Test
    func testDebug() throws {
        #expect(BuildConfiguration.isDebug)
        #expect(!BuildConfiguration.isRelease)
    }
}
