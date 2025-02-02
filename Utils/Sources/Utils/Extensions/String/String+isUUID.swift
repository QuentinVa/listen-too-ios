//
//  String+isUUID.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Foundation

extension String {

    /// Check if a string is a valid Foundation UUID
    public var isUUID: Bool {
        UUID(uuidString: self) != nil
    }
}
