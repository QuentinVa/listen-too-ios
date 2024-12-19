//
//  RouterMacroTests.swift
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

final class RouterMacroTests: XCTestCase {

    private let macros = ["Router": RouterMacro.self]

    func testMacroAllArguments() {
        assertMacroExpansion(
            """
            @Router(
                baseURL: kConsentRemoteDataSourceURL,
                apiKey: kConsentRemoteDataSourceApiKey
            )
            final class RemoteDataSource {
            }
            """,
            expandedSource:
            """
            final class RemoteDataSource {

                private let router = Router(
                    baseURL: URL(string: kConsentRemoteDataSourceURL),
                    apiKey: kConsentRemoteDataSourceApiKey
                )
            }
            """,
            macros: macros,
            indentationWidth: .spaces(4)
        )
    }

    func testMacroBaseURLOnly() {
        assertMacroExpansion(
            """
            @Router(
                baseURL: kConsentRemoteDataSourceURL
            )
            final class RemoteDataSource {
            }
            """,
            expandedSource:
            """
            final class RemoteDataSource {

                private let router = Router(
                    baseURL: URL(string: kConsentRemoteDataSourceURL)
                )
            }
            """,
            macros: macros,
            indentationWidth: .spaces(4)
        )
    }

    func testShowDiagnosticMessage() {
        assertMacroExpansion(
            """
            @Router(
                baseURL: "kConsentRemoteDataSourceURL",
                apiKey: "kConsentRemoteDataSourceApiKey"
            )
            final class RemoteDataSource {
            }
            """,
            expandedSource:
            """
            final class RemoteDataSource {
            }
            """,
            diagnostics: [
                DiagnosticSpec(
                    message: "No declaration argument provided.",
                    line: 1,
                    column: 1,
                    severity: .error
                )
            ],
            macros: macros,
            indentationWidth: .spaces(4)
        )
    }
}

#endif
