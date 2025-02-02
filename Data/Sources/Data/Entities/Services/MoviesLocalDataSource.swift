//
//  MoviesLocalDataSource.swift
//  
//
//  Created by Quentin Varlet on 02/03/2023.
//

import Combine

protocol MoviesLocalDataSourceProtocol: AnyObject {

    func setFavorite(episodesId: [String])
    func getFavorites() async throws -> [String]
}

final class MoviesLocalDataSource: LocalDataSource, MoviesLocalDataSourceProtocol {

    // MARK: Properties

    private var cancellables = Set<AnyCancellable>()

    // MARK: Init

    override init(
        userDefaultsStorage: UserDefaultsStorageProtocol = UserDefaultsStorage()
    ) {
        super.init(
            userDefaultsStorage: userDefaultsStorage
        )
    }

    // MARK: MoviesLocalDataSourceProtocol

    func setFavorite(episodesId: [String]) {
        userDefaultsStorage.userDefaults.favoriteMovies = episodesId
    }

    func getFavorites() async throws -> [String] {
        userDefaultsStorage.userDefaults.favoriteMovies
    }
}
