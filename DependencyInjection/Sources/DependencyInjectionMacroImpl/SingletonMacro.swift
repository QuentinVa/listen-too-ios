//
//  SingletonMacro.swift
//  DependencyInjection
//
//  Created by Richard Bergoin on 12/09/2024.
//

#if os(macOS)

import SwiftDiagnostics
public import SwiftSyntax
public import SwiftSyntaxMacros

public struct SingletonMacro: MemberMacro {

    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {

        var classOrActorName: String?
        var memberBlock: MemberBlockSyntax?
        if let classDecl = declaration.as(ClassDeclSyntax.self) {
            classOrActorName = classDecl.name.text
            memberBlock = classDecl.memberBlock
        } else if let actorDecl = declaration.as(ActorDeclSyntax.self) {
            classOrActorName = actorDecl.name.text
            memberBlock = actorDecl.memberBlock
        }
        guard
            let classOrActorName,
            let memberBlock
        else {
            return []
        }
        // We can check if final keywork is present
        // and if all initializers are fileprivate or private

        var expansions = [DeclSyntax]()
        expansions.append("public static let shared = \(raw: classOrActorName)()")

        var hasInitializer = false
        for member in memberBlock.members where member.decl.as(InitializerDeclSyntax.self) != nil {
            hasInitializer = true
            break
        }
        if !hasInitializer {
            expansions.append(
                """
                private init() {
                }
                """
            )
        }
        expansions.append(
            """
            #if DEBUG
            static func testableInstance() -> \(raw: classOrActorName) {
                return \(raw: classOrActorName)()
            }
            #endif
            """
        )
        return expansions
    }
}

#endif
