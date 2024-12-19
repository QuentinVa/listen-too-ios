//
//  String+kebabCased.swift
//  Data
//
//  Created by Quentin Varlet on 19/12/2024.
//

extension String {

    public func kebabCased() -> String {
        String(
            self.replacingOccurrences(of: " ", with: "")
                .splitBefore { $0.isUppercase }
                .joined(separator: "-")
        )
        .lowercased()
    }
}
