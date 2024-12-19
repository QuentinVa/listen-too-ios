//
//  Data+base64URLEncodedString.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

public import Foundation

extension Data {

    // Returns a Base64 URL-encoded string without padding.
    public var base64URLEncodedString: String {
        base64EncodedString()
            .replacingOccurrences(of: "=", with: "")
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .whitespacesTrimmed
    }
}
