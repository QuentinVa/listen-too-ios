//
//  Trimmed.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Foundation

@propertyWrapper
public struct Trimmed<T: StringPropertyWrapperProtocol>: Equatable, Hashable {

    private var value: T
    private let characterSet: CharacterSet

    public var wrappedValue: T {
        get { value }
        set {
            guard let stringValue = newValue as? String else { return }
            value = T(stringValue.trimmingCharacters(in: characterSet))
        }
    }

    public init(wrappedValue: T) {
        self.init(wrappedValue: wrappedValue, characterSet: .whitespacesAndNewlines)
    }

    private init(wrappedValue: T, characterSet: CharacterSet) {
        self.value = T.defaultValue
        self.characterSet = characterSet
        self.wrappedValue = wrappedValue
    }
}
