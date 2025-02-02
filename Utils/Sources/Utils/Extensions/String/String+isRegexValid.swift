//
//  String+isRegexValid.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Foundation

extension String {

    public func isRegexValid(pattern: String) -> Bool {
        do {
            let regex = try NSRegularExpression(
                pattern: pattern,
                options: .caseInsensitive
            )

            return regex.firstMatch(
                in: self,
                options: NSRegularExpression.MatchingOptions(rawValue: 0),
                range: NSRange(
                    location: 0,
                    length: self.count
                )
            ) != nil
        } catch {
            return false
        }
    }
}
