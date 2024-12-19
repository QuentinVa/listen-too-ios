//
//  Data+toDictionary.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

public import Foundation

extension Data {

    // swiftlint:disable:next discouraged_optional_collection
    public var toDictionary: [String: Any]? {
        try? JSONSerialization.jsonObject(
            with: self,
            options: []
        ) as? [String: Any]
    }
}
