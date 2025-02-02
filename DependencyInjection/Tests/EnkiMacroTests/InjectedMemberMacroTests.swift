//
//  InjectedMemberMacroTests.swift
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

final class InjectedMemberMacroTests: XCTestCase {

    private let macros = ["InjectedMember": InjectedMemberMacro.self]

    func testInjected() {
        assertMacroExpansion(
            """
            @InjectedMember(\\.toBeInjected)
            final class ToBeInjectedUseCase {
            }
            """,
            expandedSource:
            """
            final class ToBeInjectedUseCase {

                private let toBeInjected: ToBeInjectedProtocol = {
                    // use InjectedValues[\\.toBeInjected] when @Injected() property wrapper is removed
                    InjectedValues.valueFor(\\.toBeInjected)
                }()
            }
            """,
            macros: macros,
            indentationWidth: .spaces(4)
        )
    }

    func testInjectedWithProtocolSpecified() {
        assertMacroExpansion(
            """
            @InjectedMember(\\.toBeInjected, protocol: KeyPathNameDiffersOfProtocol)
            final class ToBeInjectedUseCase {
            }
            """,
            expandedSource:
            """
            final class ToBeInjectedUseCase {

                private let toBeInjected: KeyPathNameDiffersOfProtocol = {
                    // use InjectedValues[\\.toBeInjected] when @Injected() property wrapper is removed
                    InjectedValues.valueFor(\\.toBeInjected)
                }()
            }
            """,
            macros: macros,
            indentationWidth: .spaces(4)
        )
    }

    func testInjectedWithModifiersSpecified() {
        assertMacroExpansion(
            """
            @InjectedMember(\\.toBeInjected, modifiers: "nonisolated public")
            final class ToBeInjectedUseCase {
            }
            """,
            expandedSource:
            """
            final class ToBeInjectedUseCase {

                nonisolated public let toBeInjected: ToBeInjectedProtocol = {
                    // use InjectedValues[\\.toBeInjected] when @Injected() property wrapper is removed
                    InjectedValues.valueFor(\\.toBeInjected)
                }()
            }
            """,
            macros: macros,
            indentationWidth: .spaces(4)
        )
    }

    func testInjectedWithProtocolAndModifiersSpecified() {
        assertMacroExpansion(
            """
            @InjectedMember(\\.toBeInjected, protocol: KeyPathNameDiffersOfProtocol, modifiers: "public")
            final class ToBeInjectedUseCase {
            }
            """,
            expandedSource:
            """
            final class ToBeInjectedUseCase {

                public let toBeInjected: KeyPathNameDiffersOfProtocol = {
                    // use InjectedValues[\\.toBeInjected] when @Injected() property wrapper is removed
                    InjectedValues.valueFor(\\.toBeInjected)
                }()
            }
            """,
            macros: macros,
            indentationWidth: .spaces(4)
        )
    }
}

#endif
