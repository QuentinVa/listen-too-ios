//
//  Double+toStringWithDecimal.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

extension Double {

    public var toStringWithDecimal: String {
        String(format: "%.1F", self)
    }
}
