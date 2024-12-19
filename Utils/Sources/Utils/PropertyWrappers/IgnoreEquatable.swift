//
//  IgnoreEquatable.swift
//  Data
//
//  Created by Quentin Varlet on 19/12/2024.
//

@propertyWrapper
public struct IgnoreEquatable<Wrapped>: Equatable {

    // MARK: Properties

    public var wrappedValue: Wrapped

    // MARK: Init

    public init(wrappedValue: Wrapped) {
        self.wrappedValue = wrappedValue
    }

    // MARK: Equatable

    public static func == (
        lhs: IgnoreEquatable<Wrapped>,
        rhs: IgnoreEquatable<Wrapped>
    ) -> Bool {
        true
    }
}
