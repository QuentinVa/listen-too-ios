//
//  UserDefaults+Properties.swift
//  
//
//  Created by Quentin Varlet on 02/03/2023.
//

import Foundation

extension UserDefaults {

    // MARK: Properties

    @objc public dynamic var favoriteMovies: [String] {
        get { UserDefaults.standard.array(forKey: "Favorites") as? [String] ?? [] }
        set { UserDefaults.standard.set(newValue, forKey: "Favorites") }
    }
}
