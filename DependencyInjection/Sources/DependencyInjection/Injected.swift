//
//  Injected.swift
//  
//
//  Created by Rémi Rodrigues on 25/03/2023.
//

@propertyWrapper
public struct Injected<T> {

    // MARK: Properties

    private let keyPath: KeyPath<InjectedValues, T>

    public private(set) lazy var wrappedValue: T = {
        InjectedValues[keyPath]
    }()

    // MARK: Init

    public init(_ keyPath: KeyPath<InjectedValues, T>) {
        self.keyPath = keyPath
    }
}
