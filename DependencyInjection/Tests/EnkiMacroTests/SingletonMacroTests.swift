//
//  SingletonMacroTests.swift
//  DependencyInjection
//
//  Created by Quentin Varlet on 19/12/2024.
//

#if os(macOS)

import DependencyInjection
import DependencyInjectionMacroImpl
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

final class SingletonMacroTests: XCTestCase {

    private let macros = ["Singleton": SingletonMacro.self]

    func testSingleton() {
        assertMacroExpansion(
            """
            @Singleton
            final class UniqueNeeded {
            }
            """,
            expandedSource:
            """
            final class UniqueNeeded {

                public static let shared = UniqueNeeded()

                private init() {
                }

                #if DEBUG
                static func testableInstance() -> UniqueNeeded {
                    return UniqueNeeded()
                }
                #endif
            }
            """,
            macros: macros,
            indentationWidth: .spaces(4)
        )
    }

    func testSingletonOnActor() {
        assertMacroExpansion(
            """
            @Singleton
            final actor UniqueNeeded {
            }
            """,
            expandedSource:
            """
            final actor UniqueNeeded {

                public static let shared = UniqueNeeded()

                private init() {
                }

                #if DEBUG
                static func testableInstance() -> UniqueNeeded {
                    return UniqueNeeded()
                }
                #endif
            }
            """,
            macros: macros,
            indentationWidth: .spaces(4)
        )
    }

    func testSingletonInitCustom() {
        assertMacroExpansion(
            """
            @Singleton
            final class UniqueNeeded {

                var number: Int
                private init(number: Int) {
                    self.number = number
                }
            }
            """,
            expandedSource:
            """
            final class UniqueNeeded {

                var number: Int
                private init(number: Int) {
                    self.number = number
                }

                public static let shared = UniqueNeeded()

                #if DEBUG
                static func testableInstance() -> UniqueNeeded {
                    return UniqueNeeded()
                }
                #endif
            }
            """,
            macros: macros,
            indentationWidth: .spaces(4)
        )
    }
}

#endif
