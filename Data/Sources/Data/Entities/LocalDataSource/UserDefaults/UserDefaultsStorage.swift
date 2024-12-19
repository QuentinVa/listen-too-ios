//
//  UserDefaultsStorage.swift
//  
//
//  Created by Quentin Varlet on 02/03/2023.
//

import Foundation

protocol UserDefaultsStorageProtocol {

    var userDefaults: UserDefaults { get }

    init(suiteName: String)
}

final class UserDefaultsStorage: UserDefaultsStorageProtocol {

    // MARK: UserDefaultStorageProtocol

    let userDefaults: UserDefaults

    // MARK: Init

    init(suiteName: String = "group.com.QuentinVa.listen-too-ios.store") {
        self.userDefaults = UserDefaults(suiteName: suiteName) ?? UserDefaults.standard
    }
}
