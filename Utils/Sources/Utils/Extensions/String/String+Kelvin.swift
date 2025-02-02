//
//  String+Kelvin.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Foundation

extension String {

    public var toKelvinValue: Double? {
        var valueString = self

        if valueString.hasPrefix("T") {
            valueString = String(valueString.dropFirst())
        }

        if valueString.hasSuffix("K") {
            valueString = String(valueString.dropLast())
        }

        return Double(valueString)
    }
}
