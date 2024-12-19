//
//  String+maskSuffix.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Foundation

extension String {

    public func maskSuffix(keep numberOfChars: Int) -> String {
        var numberOfCharsToKeep = max(numberOfChars, 0)
        numberOfCharsToKeep = min(numberOfCharsToKeep, self.count)

        let start = prefix(numberOfCharsToKeep)
        let end = String(dropFirst(numberOfCharsToKeep).map { _ in Character("*") })

        return start + end
    }
}
