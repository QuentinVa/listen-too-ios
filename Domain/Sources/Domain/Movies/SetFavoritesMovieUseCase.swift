//
//  SetFavoritesMovieUseCase.swift
//  
//
//  Created by Quentin Varlet on 02/03/2023.
//

import Combine
import Data
import Foundation

public protocol SetFavoritesMovieUseCaseProtocol: AnyObject {
    func perform(episodesId: [String])
}

public final class SetFavoritesMovieUseCase: SetFavoritesMovieUseCaseProtocol {

    // MARK: Properties

    private let moviesRepository: MoviesRepositoryProtocol

    // MARK: Init

    public init(moviesRepository: MoviesRepositoryProtocol = MoviesRepository.shared) {
        self.moviesRepository = moviesRepository
    }

    // MARK: SetFavoriteMovieUseCaseProtocol

    public func perform(episodesId: [String]) {
        moviesRepository.setFavorite(episodesId: episodesId)
    }
}
