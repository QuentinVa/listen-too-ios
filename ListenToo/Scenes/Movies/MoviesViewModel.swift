//
//  MoviesViewModel.swift
//  App iOS
//
//  Created by Quentin Varlet on 28/02/2023.
//

import Combine
import Domain
import Foundation

final class MoviesViewModel: ObservableObject {

    // MARK: Properties

    private var getMoviesUseCase: GetMoviesUseCaseProtocol?
    private var getFavoritesUseCase: GetFavoritesMovieUseCaseProtocol?
    private var setFavoritesUseCase: SetFavoritesMovieUseCaseProtocol?

    @Published var favorites: Set<String> = []

    var moviesList: [Movie]?

    var sortedMovies: [Movie] {
        get {
            moviesList?.sorted(by: { $0.episodeId < $1.episodeId }) ?? []
        }
        set {
            moviesList = newValue
        }
    }

    // MARK: Init

    init(
        getMoviesUseCase: GetMoviesUseCaseProtocol = GetMoviesUseCase(),
        getFavoritesUseCase: GetFavoritesMovieUseCaseProtocol = GetFavoritesMovieUseCase(),
        setFavoritesUseCase: SetFavoritesMovieUseCaseProtocol = SetFavoritesMovieUseCase()
    ) {
        self.getMoviesUseCase = getMoviesUseCase
        self.getFavoritesUseCase = getFavoritesUseCase
        self.setFavoritesUseCase = setFavoritesUseCase
    }

    // MARK: Function

    @MainActor
    func getMovies() async throws {
        moviesList = try await getMoviesUseCase?.perform().results
        self.favorites = try await Set(getFavoritesUseCase?.performs() ?? [])
    }

    func add(_ movie: Movie) {
        favorites.insert(String(movie.episodeId))
        save()
    }

    func remove(_ movie: Movie) {
        favorites.remove(String(movie.episodeId))
        save()
    }

    func contains(_ movie: Movie) -> Bool {
        favorites.contains(String(movie.episodeId))
    }

    func save() {
        setFavoritesUseCase?.perform(episodesId: Array(self.favorites))
    }
}
