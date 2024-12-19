//
//  String+replaceFirstOccurrence.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

extension String {

    public func replaceFirstOccurrence(of pattern: String, with replacement: String) -> String {
        guard !self.isEmpty else { return "" }
        if let range = self.range(of: pattern, options: .caseInsensitive) {
            return self.replacingCharacters(in: range, with: replacement)
        } else {
            return self
        }
    }
}
