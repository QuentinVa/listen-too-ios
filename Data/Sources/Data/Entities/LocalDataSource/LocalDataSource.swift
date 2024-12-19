//
//  LocalDataSource.swift
//  
//
//  Created by Quentin Varlet on 02/03/2023.
//

import Foundation

protocol LocalDataSourceProtocol: AnyObject {

    var userDefaultsStorage: UserDefaultsStorageProtocol { get }
}

class LocalDataSource: LocalDataSourceProtocol {

    // MARK: LocalDataSourceProtocol

    let userDefaultsStorage: UserDefaultsStorageProtocol

    // MARK: Init

    init(
        userDefaultsStorage: UserDefaultsStorageProtocol = UserDefaultsStorage()
    ) {
        self.userDefaultsStorage = userDefaultsStorage
    }
}
