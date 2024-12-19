//
//  String+removingHTMLTags.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Foundation

extension String {

    public func removingHTMLTags() -> String {
        self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
