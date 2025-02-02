//
//  String+whitespacesTrimmed.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Foundation

extension String {

    public var whitespacesTrimmed: String {
        self.trimmingCharacters(in: .whitespaces)
    }

    public var whitespacesAndNewlinesTrimmed: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
