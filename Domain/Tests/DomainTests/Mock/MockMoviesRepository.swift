//
//  MockMoviesRepository.swift
//  
//
//  Created by Quentin Varlet on 10/03/2023.
//

import Data

// swiftlint:disable:file no_magic_numbers discouraged_optional_collection
final class MockMoviesRepository: MoviesRepositoryProtocol {

    // MARK: Data

    let mockMoviesResponseDTO = Data.MoviesDTO(
        count: 3,
        next: 3,
        preview: 1,
        results: MovieDTO.dummies
    )

    let mockArrayFavoritesMovies = ["1", "2", "4"]

    // MARK: Properties

    var getMovies = false
    var setMovies = false
    var setFavorites = false
    var setFavoritesParams: [String]?

    // MARK: MoviesRemoteDataSourceProtocol

    func get() async throws -> Data.MoviesDTO {
        getMovies = true
        return mockMoviesResponseDTO
    }

    func getFavorites() async throws -> [String] {
        setFavorites = true
        return mockArrayFavoritesMovies
    }

    func setFavorite(episodesId: [String]) {
        setFavoritesParams = episodesId
        setMovies = true
    }
}
