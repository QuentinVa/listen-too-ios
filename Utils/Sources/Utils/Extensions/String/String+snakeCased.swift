//
//  String+snakeCased.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

extension String {

    public func snakeCased() -> String {
        String(
            self.replacingOccurrences(of: " ", with: "")
                .splitBefore { $0.isUppercase }
                .joined(separator: "_")
        )
        .lowercased()
    }
}
