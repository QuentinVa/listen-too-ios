//
//  InjectionKey.swift
//  
//
//  Created by Rémi Rodrigues on 25/03/2023.
//

public protocol InjectionKey {

    /// The associated type representing the type of the dependency injection key's value.
    associatedtype Value

    /// The next value for the dependency injection key.
    static var nextInjectionFactoryClosures: [(() -> Self.Value)] { get set }

    /// The default value for the dependency injection key.
    static var defaultFactoryClosure: () -> Self.Value { get set }
}

extension InjectionKey {

    static var currentValue: Self.Value {
        withSafeConcurrencyInjections {
            if let nextInjectionFactoryClosure = nextInjectionFactoryClosures.popLast() {
                let value = nextInjectionFactoryClosure()
                return value
            } else {
                return defaultFactoryClosure()
            }
        }
    }
}
