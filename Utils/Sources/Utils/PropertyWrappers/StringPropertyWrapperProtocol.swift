//
//  StringPropertyWrapperProtocol.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

public protocol StringPropertyWrapperProtocol: Equatable, Hashable, Sendable {

    static var defaultValue: Self { get }

    init(_ string: String)
}

extension String: StringPropertyWrapperProtocol {

    public static let defaultValue: Self = ""

    public init(_ string: String) {
        self = string
    }
}

extension Optional: StringPropertyWrapperProtocol where Wrapped == String {

    public static let defaultValue: Self = nil

    public init(_ string: String) {
        self = string
    }
}
