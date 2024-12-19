//
//  DependencyInjectionMacro.swift
//
//
//  Created by Richard Bergoin on 17/10/2023.
//

@attached(accessor, names: named(get), named(set))
@attached(peer, names: arbitrary)
public macro Inject(exposeDefaultSetter: Bool = false) =
    #externalMacro(module: "DependencyInjectionMacroImpl", type: "InjectMacro")

@attached(member, names: arbitrary)
public macro InjectedMember<T>(_ key: KeyPath<InjectedValues, T>, protocol: T.Type = T.self, modifiers: String = "") =
    #externalMacro(module: "DependencyInjectionMacroImpl", type: "InjectedMemberMacro")

// Possible to manage multiple argument with pack iteration :
// @attached(member, names: arbitrary)
// public macro InjectedMembers<each T>(_ key: repeat KeyPath<InjectedValues, each T>) =
//     #externalMacro(module: "DependencyInjectionMacroImpl", type: "InjectedMemberMacro")
// Usage :
// @InjectedMembers(
//    \.toBeInjected,
//    \.toBeInjected2
// )
// final class NeedingToBeInjectObject {}

@attached(member, names: arbitrary)
public macro APIRouter(baseURL: String, apiKey: String? = nil) =
    #externalMacro(module: "DependencyInjectionMacroImpl", type: "RouterMacro")

@attached(member, names: arbitrary)
public macro Singleton() = #externalMacro(module: "DependencyInjectionMacroImpl", type: "SingletonMacro")
