//
//  InjectedMemberMacro.swift
//  DependencyInjection
//
//  Created by Richard Bergoin on 03/09/2024.
//

#if os(macOS)

import SwiftDiagnostics
public import SwiftSyntax
public import SwiftSyntaxMacros

public struct InjectedMemberMacro: MemberMacro {

    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {

        guard
            case let .argumentList(arguments) = node.arguments,
            let labeledDecl = arguments.first
        else {
            return []
        }

        // \.toBeInjected -> toBeInjected
        guard
            let keyPathDecl = labeledDecl.expression.as(KeyPathExprSyntax.self),
            let keyPathFirstComponent = keyPathDecl.components.first?.component.as(KeyPathPropertyComponentSyntax.self)
        else {
            return []
        }
        let keyPathBaseName = keyPathFirstComponent.declName.baseName.text

        var protocolNameBasedOnKeyPath = ""
        if let protocolArgument = arguments.first(where: { $0.label?.text == "protocol" }),
            let expressionDecl = protocolArgument.expression.as(DeclReferenceExprSyntax.self) {
            protocolNameBasedOnKeyPath = expressionDecl.baseName.text
        } else {
            // toBeInjected -> ToBeInjectedProtocol
            guard let first = keyPathBaseName.first else {
                return []
            }
            protocolNameBasedOnKeyPath = "\(first.uppercased())\(keyPathBaseName.dropFirst())Protocol"
        }

        var propertyModifiers = "private"
        if let modifiers = arguments.first(where: { $0.label?.text == "modifiers" }),
            let stringLiteralExprSyntax = modifiers.expression.as(StringLiteralExprSyntax.self),
            let stringSegmentSyntax = stringLiteralExprSyntax.segments.first?.as(StringSegmentSyntax.self) {
            propertyModifiers = stringSegmentSyntax.content.text
        }

        return [
            """
            \(raw: propertyModifiers) let \(raw: keyPathBaseName): \(raw: protocolNameBasedOnKeyPath) = {
                // use InjectedValues[\(labeledDecl.expression)] when @Injected() property wrapper is removed
                InjectedValues.valueFor(\(labeledDecl.expression))
            }()
            """
        ]
    }
}

#endif
