//
//  GetEpisodeMovieUseCase.swift
//
//
//  Created by Quentin Varlet on 10/03/2023.
//

import Data
import Foundation

public protocol GetEpisodeMovieUseCaseProtocol: AnyObject {

    func perform(episodeId: Int) async throws -> Movie
}

public final class GetEpisodeMovieUseCase: GetEpisodeMovieUseCaseProtocol {

    // MARK: Properties

    private let adapter = MovieAdapter()

    let moviesRepository: MoviesRepositoryProtocol

    // MARK: Init

    public init(
        moviesRepository: MoviesRepositoryProtocol = MoviesRepository.shared
    ) {
        self.moviesRepository = moviesRepository
    }

    // MARK: GetEpisodeMovieUseCaseProtocol

    public func perform(episodeId: Int) async throws -> Movie {
        let movieDTO = try await moviesRepository.getEpisode(episodeId: episodeId)
        return adapter.movie(from: movieDTO)
    }
}
