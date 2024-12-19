//  swiftlint:disable:this file_name
//  String+isNullOrEmpty.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

extension Optional where Wrapped == String {

    public var isNullOrEmpty: Bool {
        self?.isEmpty ?? true
    }
}
