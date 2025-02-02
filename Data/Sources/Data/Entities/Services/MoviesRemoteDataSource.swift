//
//  MoviesRemoteDataSource.swift
//  
//
//  Created by Quentin Varlet on 28/02/2023.
//

protocol MoviesRemoteDataSourceProtocol: AnyObject {

    func get() async throws -> MoviesDTO
    func getEpisode(episodeId: Int) async throws -> MovieDTO
}

final class MoviesRemoteDataSource: RemoteDataSource, MoviesRemoteDataSourceProtocol {

    // MARK: Properties

    let router: MoviesRouterProtocol

    // MARK: Init

    init(
        network: NetworkProtocol = Network(),
        router: MoviesRouterProtocol = MoviesRouter()
    ) {
        self.router = router
        super.init(network: network)
    }

    // MARK: MoviesRemoteDataSourceProtocol

    func get() async throws -> MoviesDTO {
        try await network.load(
            request: router.getMovies()
        )
    }
    
    func getEpisode(episodeId: Int) async throws -> MovieDTO {
        try await network.load(
            request: router.getEpisode(episodeId: episodeId)
        )
    }
}
