//
//  RouterMacro.swift
//  DependencyInjection
//
//  Created by JC Neboit on 08/10/2024.
//

#if os(macOS)

import SwiftDiagnostics
public import SwiftSyntax
public import SwiftSyntaxMacros

public struct RouterMacro: MemberMacro {

    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        guard case let .argumentList(arguments) = node.arguments else {
            return []
        }

        guard let baseURLArgument = arguments.first(where: { $0.label?.text == "baseURL" }),
            let baseURLDeclReferenceExprSyntax = baseURLArgument.expression.as(DeclReferenceExprSyntax.self) else {
            context.diagnose(Diagnostic(node: Syntax(node), message: Feedback.noDeclarationArgument))
            return []
        }

        let baseURL = baseURLDeclReferenceExprSyntax.baseName.text

        var apiKey: String?
        if let apiKeyArgument = arguments.first(where: { $0.label?.text == "apiKey" }) {
            guard let apiKeyDeclReferenceExprSyntax = apiKeyArgument.expression.as(DeclReferenceExprSyntax.self) else {
                context.diagnose(Diagnostic(node: Syntax(node), message: Feedback.noDeclarationArgument))
                return []
            }
            apiKey = apiKeyDeclReferenceExprSyntax.baseName.text
        }

        if let apiKey {
            return [
                """
                private let router = Router(
                    baseURL: URL(string: \(raw: baseURL)),
                    apiKey: \(raw: apiKey)
                )
                """
            ]
        } else {
            return [
                """
                private let router = Router(
                    baseURL: URL(string: \(raw: baseURL))
                )
                """
            ]
        }
    }
}

#endif
