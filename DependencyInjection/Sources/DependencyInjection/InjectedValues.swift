//
//  InjectedValues.swift
//  
//
//  Created by Rémi Rodrigues on 25/03/2023.
//

import Foundation

public struct InjectedValues: Sendable {

    /// This is only used as an accessor to the computed properties within extensions of `InjectedValues`.
    private static let current = Self()

    public static func valueFor<T>(_ keyPath: KeyPath<Self, T>) -> T {
        withSafeConcurrencyInjections {
            current[keyPath: keyPath]
        }
    }

    /// A static subscript for updating the `currentValue` of `InjectionKey` instances.
    public static subscript<K>(key: K.Type) -> K.Value where K: InjectionKey {
        key.currentValue
    }

    /// A static subscript accessor for references dependencies directly.
    public static subscript<T>(_ keyPath: KeyPath<Self, T>) -> T {
        current[keyPath: keyPath]
    }
}
