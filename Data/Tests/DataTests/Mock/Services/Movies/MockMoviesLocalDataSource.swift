//
//  MockMoviesLocalDataSource.swift
//  
//
//  Created by Quentin Varlet on 09/03/2023.
//

import Foundation

@testable import Data

// swiftlint:disable:file discouraged_optional_collection
final class MockMoviesLocalDataSource: MoviesLocalDataSourceProtocol {

    // MARK: Data

    let mockArrayFavoritesMovies = ["1", "2", "4"]

    // MARK: Properties

    var getFavorite = false
    var getFavoriteParams: [String]?

    var setFavorite = false
    var setFavoriteParams: [String]?

    // MARK: UserRemoteDataSourceProtocol

    func setFavorite(episodesId: [String]) {
        setFavorite = true
        setFavoriteParams = episodesId
    }

    func getFavorites() async throws -> [String] {
        getFavorite = true
        getFavoriteParams = mockArrayFavoritesMovies
        return mockArrayFavoritesMovies
    }
}
