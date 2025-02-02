//
//  InjectMacroTests.swift
//
//
//  Created by Richard Bergoin on 18/10/2023.
//

#if os(macOS)

import DependencyInjection
import DependencyInjectionMacroImpl
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// swiftlint:disable line_length function_body_length type_body_length

final class InjectMacroTests: XCTestCase {

    private let macros = ["Inject": InjectMacro.self]

    func testInject() {
        for modifier in ["", "internal ", "public ", "private "] {
            sharedTestInject(modifier: modifier)
        }
    }

    private func sharedTestInject(modifier: String) {
        assertMacroExpansion(
            """
            public protocol ProvisionDeviceUseCaseProtocol: AnyObject {}
            final class ProvisionDeviceUseCase: ProvisionDeviceUseCaseProtocol {}

            extension InjectedValues {

                @Inject \(modifier)var provisionDeviceUseCase: ProvisionDeviceUseCaseProtocol = ProvisionDeviceUseCase()
            }
            """,
        expandedSource:
            """
            public protocol ProvisionDeviceUseCaseProtocol: AnyObject {}
            final class ProvisionDeviceUseCase: ProvisionDeviceUseCaseProtocol {}

            extension InjectedValues {

                \(modifier)var provisionDeviceUseCase: ProvisionDeviceUseCaseProtocol {
                    get {
                        Self[ProvisionDeviceUseCase_ProvisionDeviceUseCaseProtocolKey.self]
                    }
                }

                private actor ProvisionDeviceUseCase_ProvisionDeviceUseCaseProtocolKey: InjectionKey {

                    static var nextInjectionFactoryClosures = [(() -> Value)]()

                    static var defaultFactoryClosure: () -> ProvisionDeviceUseCaseProtocol = {
                        var currentValue: ProvisionDeviceUseCaseProtocol = ProvisionDeviceUseCase()
                        return currentValue
                    }
                }

                // One time Inject closure to have DI return object given, set onlyOnce = false to replace all future calls
                \(modifier)static func inject(provisionDeviceUseCase factoryClosure: @escaping @autoclosure () -> ProvisionDeviceUseCaseProtocol, count: UInt = 1) {
                    guard InjectedValuesActor.isOnSafeConcurrencyInjectionsQueue() else {
                        fatalError("Injecting from an invalid queue")
                    }
                    for _ in 0..<count {
                        ProvisionDeviceUseCase_ProvisionDeviceUseCaseProtocolKey.nextInjectionFactoryClosures.append(factoryClosure)
                    }
                }
            }
            """,
        macros: macros,
        indentationWidth: .spaces(4)
        )
    }

    func testInjectWithExposeDefaultSetter() {
        assertMacroExpansion(
            """
            public protocol ProvisionDeviceUseCaseProtocol: AnyObject {}
            final class ProvisionDeviceUseCase: ProvisionDeviceUseCaseProtocol {}

            extension InjectedValues {

                @Inject(exposeDefaultSetter: true) var provisionDeviceUseCase: ProvisionDeviceUseCaseProtocol = ProvisionDeviceUseCase()
            }
            """,
        expandedSource:
            """
            public protocol ProvisionDeviceUseCaseProtocol: AnyObject {}
            final class ProvisionDeviceUseCase: ProvisionDeviceUseCaseProtocol {}

            extension InjectedValues {

                var provisionDeviceUseCase: ProvisionDeviceUseCaseProtocol {
                    get {
                        Self[ProvisionDeviceUseCase_ProvisionDeviceUseCaseProtocolKey.self]
                    }
                }

                private actor ProvisionDeviceUseCase_ProvisionDeviceUseCaseProtocolKey: InjectionKey {

                    static var nextInjectionFactoryClosures = [(() -> Value)]()

                    static var defaultFactoryClosure: () -> ProvisionDeviceUseCaseProtocol = {
                        var currentValue: ProvisionDeviceUseCaseProtocol = ProvisionDeviceUseCase()
                        return currentValue
                    }
                }

                // One time Inject closure to have DI return object given, set onlyOnce = false to replace all future calls
                static func inject(provisionDeviceUseCase factoryClosure: @escaping @autoclosure () -> ProvisionDeviceUseCaseProtocol, count: UInt = 1) {
                    guard InjectedValuesActor.isOnSafeConcurrencyInjectionsQueue() else {
                        fatalError("Injecting from an invalid queue")
                    }
                    for _ in 0..<count {
                        ProvisionDeviceUseCase_ProvisionDeviceUseCaseProtocolKey.nextInjectionFactoryClosures.append(factoryClosure)
                    }
                }

                package static func setDefaultInjectedValue(provisionDeviceUseCase factoryClosure: @escaping @autoclosure () -> ProvisionDeviceUseCaseProtocol) {
                    ProvisionDeviceUseCase_ProvisionDeviceUseCaseProtocolKey.defaultFactoryClosure = factoryClosure
                }
            }
            """,
        macros: macros,
        indentationWidth: .spaces(4)
        )
    }

    // MARK: Singleton tests

    func testInjectWithSingleton() {
        assertMacroExpansion(
            """
            public protocol ProvisionDeviceUseCaseProtocol: AnyObject {}
            final class ProvisionDeviceUseCase: ProvisionDeviceUseCaseProtocol {

                private static let shared = ProvisionDeviceUseCase()
            }

            extension InjectedValues {

                @Inject var provisionDeviceUseCase: ProvisionDeviceUseCaseProtocol = ProvisionDeviceUseCase.shared
            }
            """,
        expandedSource:
            """
            public protocol ProvisionDeviceUseCaseProtocol: AnyObject {}
            final class ProvisionDeviceUseCase: ProvisionDeviceUseCaseProtocol {

                private static let shared = ProvisionDeviceUseCase()
            }

            extension InjectedValues {

                var provisionDeviceUseCase: ProvisionDeviceUseCaseProtocol {
                    get {
                        Self[ProvisionDeviceUseCase_ProvisionDeviceUseCaseProtocolKey.self]
                    }
                }

                private actor ProvisionDeviceUseCase_ProvisionDeviceUseCaseProtocolKey: InjectionKey {

                    static var nextInjectionFactoryClosures = [(() -> Value)]()

                    static var defaultFactoryClosure: () -> ProvisionDeviceUseCaseProtocol = {
                        var currentValue: ProvisionDeviceUseCaseProtocol = ProvisionDeviceUseCase.shared
                        return currentValue
                    }
                }

                // One time Inject closure to have DI return object given, set onlyOnce = false to replace all future calls
                static func inject(provisionDeviceUseCase factoryClosure: @escaping @autoclosure () -> ProvisionDeviceUseCaseProtocol, count: UInt = 1) {
                    guard InjectedValuesActor.isOnSafeConcurrencyInjectionsQueue() else {
                        fatalError("Injecting from an invalid queue")
                    }
                    for _ in 0..<count {
                        ProvisionDeviceUseCase_ProvisionDeviceUseCaseProtocolKey.nextInjectionFactoryClosures.append(factoryClosure)
                    }
                }
            }
            """,
        macros: macros,
        indentationWidth: .spaces(4)
        )
    }

    func testInjectWithSingleton2() {
        assertMacroExpansion(
            """
            public protocol ProvisionDeviceUseCaseProtocol: AnyObject {}
            final class ProvisionDeviceUseCase: ProvisionDeviceUseCaseProtocol {

                static func staticBuilderFunction() -> ProvisionDeviceUseCaseProtocol {
                    return ProvisionDeviceUseCase()
                }
            }

            extension InjectedValues {

                @Inject var provisionDeviceUseCase: ProvisionDeviceUseCaseProtocol = ProvisionDeviceUseCase.staticBuilderFunction()
            }
            """,
        expandedSource:
            """
            public protocol ProvisionDeviceUseCaseProtocol: AnyObject {}
            final class ProvisionDeviceUseCase: ProvisionDeviceUseCaseProtocol {

                static func staticBuilderFunction() -> ProvisionDeviceUseCaseProtocol {
                    return ProvisionDeviceUseCase()
                }
            }

            extension InjectedValues {

                var provisionDeviceUseCase: ProvisionDeviceUseCaseProtocol {
                    get {
                        Self[ProvisionDeviceUseCase_ProvisionDeviceUseCaseProtocolKey.self]
                    }
                }

                private actor ProvisionDeviceUseCase_ProvisionDeviceUseCaseProtocolKey: InjectionKey {

                    static var nextInjectionFactoryClosures = [(() -> Value)]()

                    static var defaultFactoryClosure: () -> ProvisionDeviceUseCaseProtocol = {
                        var currentValue: ProvisionDeviceUseCaseProtocol = ProvisionDeviceUseCase.staticBuilderFunction()
                        return currentValue
                    }
                }

                // One time Inject closure to have DI return object given, set onlyOnce = false to replace all future calls
                static func inject(provisionDeviceUseCase factoryClosure: @escaping @autoclosure () -> ProvisionDeviceUseCaseProtocol, count: UInt = 1) {
                    guard InjectedValuesActor.isOnSafeConcurrencyInjectionsQueue() else {
                        fatalError("Injecting from an invalid queue")
                    }
                    for _ in 0..<count {
                        ProvisionDeviceUseCase_ProvisionDeviceUseCaseProtocolKey.nextInjectionFactoryClosures.append(factoryClosure)
                    }
                }
            }
            """,
        macros: macros,
        indentationWidth: .spaces(4)
        )
    }

    func testInjectWithGlobalActor() {
        assertMacroExpansion(
            """
            public protocol ProvisionDeviceUseCaseProtocol: AnyObject {}
            final class ProvisionDeviceUseCase: ProvisionDeviceUseCaseProtocol {

                static func staticBuilderFunction() -> ProvisionDeviceUseCaseProtocol {
                    return ProvisionDeviceUseCase()
                }
            }

            extension InjectedValues {

                @MainActor @Inject var provisionDeviceUseCase: ProvisionDeviceUseCaseProtocol = ProvisionDeviceUseCase()
            }
            """,
        expandedSource:
            """
            public protocol ProvisionDeviceUseCaseProtocol: AnyObject {}
            final class ProvisionDeviceUseCase: ProvisionDeviceUseCaseProtocol {

                static func staticBuilderFunction() -> ProvisionDeviceUseCaseProtocol {
                    return ProvisionDeviceUseCase()
                }
            }

            extension InjectedValues {

                @MainActor var provisionDeviceUseCase: ProvisionDeviceUseCaseProtocol {
                    get {
                        Self[ProvisionDeviceUseCase_ProvisionDeviceUseCaseProtocolKey.self]
                    }
                }

                @MainActor
                private protocol ProvisionDeviceUseCase_MainActorInjectionKey: InjectionKey {
                }

                private struct ProvisionDeviceUseCase_ProvisionDeviceUseCaseProtocolKey: ProvisionDeviceUseCase_MainActorInjectionKey {

                    static var nextInjectionFactoryClosures = [(() -> Value)]()

                    static var defaultFactoryClosure: () -> ProvisionDeviceUseCaseProtocol = {
                        var currentValue: ProvisionDeviceUseCaseProtocol = ProvisionDeviceUseCase()
                        return currentValue
                    }
                }

                // One time Inject closure to have DI return object given, set onlyOnce = false to replace all future calls
                @MainActor
                static func inject(provisionDeviceUseCase factoryClosure: @escaping @autoclosure () -> ProvisionDeviceUseCaseProtocol, count: UInt = 1) {
                    guard InjectedValuesActor.isOnSafeConcurrencyInjectionsQueue() else {
                        fatalError("Injecting from an invalid queue")
                    }
                    for _ in 0..<count {
                        ProvisionDeviceUseCase_ProvisionDeviceUseCaseProtocolKey.nextInjectionFactoryClosures.append(factoryClosure)
                    }
                }
            }
            """,
        macros: macros,
        indentationWidth: .spaces(4)
        )
    }
}

#endif
