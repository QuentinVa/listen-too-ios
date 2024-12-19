//
//  FavoritesViewModel.swift
//  App iOS
//
//  Created by Quentin Varlet on 09/03/2023.
//

import Combine
import Domain
import Foundation

final class FavoriteViewModel: ObservableObject {

    // MARK: Properties

    private var getMoviesUseCase: GetMoviesUseCaseProtocol?
    private var getFavoritesMovies: GetFavoritesMovieUseCaseProtocol?

    @Published var favorites: [String] = []
    @Published var moviesList: [Movie]?
    @Published var favoriteList: [Movie]?

    // MARK: Init

    init(
        getMoviesUseCase: GetMoviesUseCaseProtocol = GetMoviesUseCase(),
        getFavoritesMovies: GetFavoritesMovieUseCaseProtocol = GetFavoritesMovieUseCase()
    ) {
        self.getMoviesUseCase = getMoviesUseCase
        self.getFavoritesMovies = getFavoritesMovies
    }

    // MARK: Public Methods

    @MainActor
    func getMovies() async throws {

        // TODO Change with loader
        moviesList = []
        favoriteList = []

        moviesList = try await self.getMoviesUseCase?.perform().results
        favorites = try await self.getFavoritesMovies?.performs() ?? []

        getFavoriesMovies()
    }

    func getFavoriesMovies() {
        let filterFavorites = moviesList?.filter {
            favorites.contains(String($0.episodeId))
        }
            .sorted(by: { $0.episodeId < $1.episodeId }) ?? []
        self.favoriteList = filterFavorites
    }
}
