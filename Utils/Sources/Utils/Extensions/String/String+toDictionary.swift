//
//  String+toDictionary.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Foundation

extension String {

    // swiftlint:disable:next discouraged_optional_collection
    public var toDictionary: [String: Any]? {
        Data(self.utf8).toDictionary
    }
}
