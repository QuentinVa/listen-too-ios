//
//  MovieDetailViewModel.swift
//  App iOS
//
//  Created by Quentin Varlet on 02/03/2023.
//

import Domain
import Foundation

final class MovieDetailsViewModel: ObservableObject {

    // MARK: Properties

    private var getEpisodeMovieUseCase: GetEpisodeMovieUseCaseProtocol?

    @Published private(set) var movie: Movie?
    @Published var episodeId: Int = 0

    // MARK: Init

    init(
        movie: Movie,
        getEpisodeMovieUseCase: GetEpisodeMovieUseCaseProtocol = GetEpisodeMovieUseCase()
    ) {
        self.getEpisodeMovieUseCase = getEpisodeMovieUseCase
        self.movie = movie
    }

    @MainActor
    func getEpisode() async throws {
        guard episodeId != 0 else {
            return
        }
        movie = try await getEpisodeMovieUseCase?.perform(episodeId: episodeId) ?? Movie.dummy
    }

    func handleURL(_ url: URL) {
        guard url.scheme == "listen-too-ios", !url.lastPathComponent.isEmpty else {
            return
        }
        episodeId = Int(url.lastPathComponent) ?? 0
    }
}
