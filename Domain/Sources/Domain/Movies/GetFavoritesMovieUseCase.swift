//
//  GetFavoritesMovieUseCase.swift
//  
//
//  Created by Quentin Varlet on 02/03/2023.
//

import Combine
import Data
import Foundation

public protocol GetFavoritesMovieUseCaseProtocol: AnyObject {

    func performs() async throws -> [String]
}

public final class GetFavoritesMovieUseCase: GetFavoritesMovieUseCaseProtocol {

    // MARK: Properties

    private var cancellables = Set<AnyCancellable>()

    let moviesRepository: MoviesRepositoryProtocol

    // MARK: Init

    public init(moviesRepository: MoviesRepositoryProtocol = MoviesRepository.shared) {
        self.moviesRepository = moviesRepository
    }

    // MARK: GetFavoritesMovieUseCaseProtocol

    public func performs() async throws -> [String] {
        try await moviesRepository.getFavorites()
    }
}
