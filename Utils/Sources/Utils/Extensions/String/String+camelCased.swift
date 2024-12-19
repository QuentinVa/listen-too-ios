//
//  String+camelCased.swift
//  Utils
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Foundation

extension String {

    public func camelCased() -> String {
        String(
            self.lowercased()
                .components(separatedBy: CharacterSet(charactersIn: "_ -"))
                .map { $0.uppercasedFirst }
                .joined()
                .lowercasedFirst
        )
    }
}
