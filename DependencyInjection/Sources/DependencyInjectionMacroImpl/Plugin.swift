//
//  Plugin.swift
//
//
//  Created by Richard Bergoin on 17/10/2023.
//

#if os(macOS) && canImport(SwiftCompilerPlugin)

import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct Plugin: CompilerPlugin {

    let providingMacros: [Macro.Type] = [
        InjectMacro.self,
        InjectedMemberMacro.self,
        SingletonMacro.self,
        RouterMacro.self
    ]
}

#endif
