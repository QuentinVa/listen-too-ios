//
//  InjectMacro.swift
//
//
//  Created by Richard Bergoin on 18/10/2023.
//

// swiftlint:disable line_length

#if os(macOS)

import SwiftDiagnostics
public import SwiftSyntax
public import SwiftSyntaxMacros

enum Feedback: String, DiagnosticMessage {

    case noDeclarationArgument
    case noDefaultArgument
    case missingAnnotation
    case notAnIdentifier

    var severity: DiagnosticSeverity { .error }

    var message: String {
        switch self {
        case .noDeclarationArgument:
            "No declaration argument provided."
        case .noDefaultArgument:
            "No default value provided."
        case .missingAnnotation:
            "No annotation provided."
        case .notAnIdentifier:
            "Can't find type to generate SomeKey: InjectionKey."
        }
    }

    var diagnosticID: MessageID {
        MessageID(domain: "InjectMacro", id: rawValue)
    }
}

public struct InjectMacro: PeerMacro {

    // swiftlint:disable:next function_body_length
    public static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {

        // Skip declarations other than variables
        guard let varDecl = declaration.as(VariableDeclSyntax.self) else {
            return []
        }

        var globalActorName: String?
        if let globalActor = varDecl.attributes.compactMap({ attribute -> IdentifierTypeSyntax? in
            guard
                let attributeSyntax = attribute.as(AttributeSyntax.self),
                let identifierTypeSyntax = attributeSyntax.attributeName.as(IdentifierTypeSyntax.self),
                identifierTypeSyntax.name.text.hasSuffix("Actor")
            else {
                return nil
            }
            return identifierTypeSyntax
        }).first {
            globalActorName = globalActor.name.text
        }

        var addDefaultInjectedFuncDecl = false
        if case let .argumentList(arguments) = node.arguments,
            arguments.first != nil {
            addDefaultInjectedFuncDecl = true
        }

        guard
            var binding = varDecl.bindings.first,
            let (identifier, identifierUppercaseFirstLetter, protocolIdentifier) =
            binding.identifierUppercaseFirstLetterAndProtocolIdentifier(of: node, in: context) else {
            context.diagnose(Diagnostic(node: Syntax(node), message: Feedback.missingAnnotation))
            return []
        }

        binding.pattern = PatternSyntax(IdentifierPatternSyntax(identifier: .identifier("currentValue")))

        let isOptionalType = binding.typeAnnotation?.type.is(OptionalTypeSyntax.self) ?? false
        let hasDefaultValue = binding.initializer != nil

        guard isOptionalType || hasDefaultValue else {
            context.diagnose(Diagnostic(node: Syntax(node), message: Feedback.noDefaultArgument))
            return []
        }

        var defaultInjectedFuncDecl = ""
        if addDefaultInjectedFuncDecl {
            defaultInjectedFuncDecl = """

            package static func setDefaultInjectedValue(\(identifier) factoryClosure: @escaping @autoclosure () -> \(protocolIdentifier)) {
                \(identifierUppercaseFirstLetter)_\(protocolIdentifier)Key.defaultFactoryClosure = factoryClosure
            }
            """
        }

        var injectFuncModifier = ""
        if let modifier = varDecl.modifiers.first {
            injectFuncModifier = modifier.name.text + " "
        }

        var actorInjectionKeyProtocol = ""
        var actorInjectionKeyProtocolName = ""
        if let globalActorName {
            actorInjectionKeyProtocolName = "\(identifierUppercaseFirstLetter)_\(globalActorName)InjectionKey"

            actorInjectionKeyProtocol = """
            @\(globalActorName)
            private protocol \(actorInjectionKeyProtocolName): InjectionKey {
            }

            """

            injectFuncModifier = """
            @\(globalActorName)
            \(injectFuncModifier)
            """
        }

        return [
            """
            \(raw: actorInjectionKeyProtocol)
            private \(raw: globalActorName == nil ? "actor" : "struct") \(raw: identifierUppercaseFirstLetter)_\(raw: protocolIdentifier)Key: \(raw: globalActorName == nil ? "InjectionKey" : "\(actorInjectionKeyProtocolName)") {

                static var nextInjectionFactoryClosures = [(() -> Value)]()

                static var defaultFactoryClosure: () -> \(raw: protocolIdentifier) = {
                    var \(binding)
                    return currentValue
                }
            }

            // One time Inject closure to have DI return object given, set onlyOnce = false to replace all future calls
            \(raw: injectFuncModifier)static func inject(\(raw: identifier) factoryClosure: @escaping @autoclosure () -> \(raw: protocolIdentifier), count: UInt = 1) {
                guard InjectedValuesActor.isOnSafeConcurrencyInjectionsQueue() else {
                    fatalError("Injecting from an invalid queue")
                }
                for _ in 0..<count {
                    \(raw: identifierUppercaseFirstLetter)_\(raw: protocolIdentifier)Key.nextInjectionFactoryClosures.append(factoryClosure)
                }
            }
            \(raw: defaultInjectedFuncDecl)
            """
        ]
    }
}

// swiftlint:disable:next no_grouping_extension
extension InjectMacro: AccessorMacro {

    public static func expansion(
        of node: AttributeSyntax,
        providingAccessorsOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [AccessorDeclSyntax] {

        // Skip declarations other than variables
        guard let varDecl = declaration.as(VariableDeclSyntax.self) else {
            return []
        }

        guard
            let binding = varDecl.bindings.first,
            let (_, identifierUppercaseFirstLetter, protocolIdentifier) =
            binding.identifierUppercaseFirstLetterAndProtocolIdentifier(of: node, in: context) else {
            context.diagnose(Diagnostic(node: Syntax(node), message: Feedback.missingAnnotation))
            return []
        }

        return [
            """
            get {
                Self[\(raw: identifierUppercaseFirstLetter)_\(raw: protocolIdentifier)Key.self]
            }
            """
        ]
    }
}

extension PatternBindingSyntax {

    // swiftlint:disable large_tuple
    func identifierUppercaseFirstLetterAndProtocolIdentifier(
        of node: AttributeSyntax,
        in context: some MacroExpansionContext
    ) -> (identifier: String, identifierUppercaseFirstLetter: String, protocolIdentifier: String)? {
        guard
            let identifier = pattern.as(IdentifierPatternSyntax.self)?.identifier.text,
            let firstIdentifierLetter = identifier.first else {
            context.diagnose(Diagnostic(node: Syntax(node), message: Feedback.notAnIdentifier))
            return nil
        }
        let identifierUppercaseFirstLetter = "\(firstIdentifierLetter.uppercased())\(identifier.dropFirst())"

        guard let protocolIdentifier = typeAnnotation?.type.as(IdentifierTypeSyntax.self)?.name.text else {
            context.diagnose(Diagnostic(node: Syntax(node), message: Feedback.notAnIdentifier))
            return nil
        }
        return (identifier, identifierUppercaseFirstLetter, protocolIdentifier)
    }
}

extension PatternBindingSyntax {

    var assignationBaseName: TokenSyntax? {
        // @Inject var x = Some()
        if let identifier = initializer?
            .value
            .as(FunctionCallExprSyntax.self)?
            .calledExpression
            .as(DeclReferenceExprSyntax.self)?
            .baseName {
            return identifier
        }
        // @Inject var x = Some.shared
        if let identifier = initializer?
            .value
            .as(MemberAccessExprSyntax.self)?
            .base?
            .as(DeclReferenceExprSyntax.self)?
            .baseName {
            return identifier
        }
        // @Inject var x = Some.staticFunc()
        if let identifier = initializer?
            .value
            .as(FunctionCallExprSyntax.self)?
            .calledExpression
            .as(MemberAccessExprSyntax.self)?
            .base?
            .as(DeclReferenceExprSyntax.self)?
            .baseName {
            return identifier
        }
        return nil
    }
}

#endif
