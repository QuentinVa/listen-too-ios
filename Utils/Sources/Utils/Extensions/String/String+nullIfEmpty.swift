//
//  String+nullIfEmpty.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

extension String {

    public var nullIfEmpty: Self? {
        self.isEmpty ? nil : self
    }
}

extension Optional where Wrapped == String {

    public var nullIfEmpty: Self {
        guard let self else { return nil }
        return self.nullIfEmpty
    }
}
