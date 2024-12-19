//
//  MockMoviesRemoteDataSource.swift
//  
//
//  Created by Quentin Varlet on 09/03/2023.
//

@testable import Data
import Foundation

// swiftlint:disable:file no_magic_numbers
final class MockMoviesRemoteDataSource: MoviesRemoteDataSourceProtocol {


    // MARK: Data

    let mockMoviesResponseDTO = MoviesDTO(
        count: 3,
        next: 4,
        preview: 2,
        results: MovieDTO.dummies
    )

    let mockMovieResponseDTO = MovieDTO(
        title: "",
        episodeId: 3,
        openingCrawl: "",
        director: "",
        producer: "",
        releaseDate: "",
        characters: [],
        planets: [],
        starships: [],
        vehicles: [],
        species: [],
        created: "",
        edited: "",
        url: URL(string: "URL")!
    )

    // MARK: Properties

    var getMovies = false

    // MARK: UserRemoteDataSourceProtocol

    func get() async throws -> MoviesDTO {
        getMovies = true

        return mockMoviesResponseDTO
    }

    func getEpisode(episodeId: Int) async throws -> MovieDTO {
        getMovies = true

        return mockMovieResponseDTO
    }

}
