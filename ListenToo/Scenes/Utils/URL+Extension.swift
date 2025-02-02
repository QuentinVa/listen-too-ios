//
//  URL+Extension.swift
//  App iOS
//
//  Created by Quentin Varlet on 10/03/2023.
//

import Foundation

extension URL {

    var isDeeplink: Bool {
        scheme == "listen-too-ios"
    }

    var tabIdentifier: Tabs? {
        guard isDeeplink else { return nil }

        switch host {
        case "films":
            return .films
        case "favorites":
            return .favorites
        case "components":
            return .components
        default:
            return nil
        }
    }
}
