//
//  GetMoviesUseCase.swift
//  
//
//  Created by Quentin Varlet on 01/03/2023.
//

import Data
import Foundation

public protocol GetMoviesUseCaseProtocol: AnyObject {

    func perform() async throws -> Movies
}

public final class GetMoviesUseCase: GetMoviesUseCaseProtocol {

    // MARK: Properties

    private let adapter = MovieAdapter()

    let moviesRepository: MoviesRepositoryProtocol

    // MARK: Init

    public init(
        moviesRepository: MoviesRepositoryProtocol = MoviesRepository.shared
    ) {
        self.moviesRepository = moviesRepository
    }

    // MARK: GetMoviesUseCaseProtocol

    public func perform() async throws -> Movies {
        let moviesDTO = try await moviesRepository.get()
        return Movies(
            count: moviesDTO.count,
            next: moviesDTO.next,
            preview: moviesDTO.preview,
            results: adapter.movies(from: moviesDTO.results)
        )
    }
}
