//
//  String+captureRegexGroups.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Foundation

extension String {

    public func captureRegexGroups(pattern: String, namedGroups: [String]) throws -> [String: String] {
        let range = NSRange(
            self.startIndex..<self.endIndex,
            in: self
        )

        let regex = try NSRegularExpression(
            pattern: pattern,
            options: []
        )

        let matches = regex.matches(
            in: self,
            options: [],
            range: range
        )

        var captures: [String: String] = [:]

        for name in namedGroups {
            for match in matches {
                let matchRange = match.range(withName: name)

                if let substringRange = Range(matchRange, in: self) {
                    let capture = String(self[substringRange])
                    captures[name] = capture
                }
            }
        }

        return captures
    }
}
