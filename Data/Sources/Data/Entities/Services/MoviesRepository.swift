//
//  MoviesRepository.swift
//  
//
//  Created by Quentin Varlet on 28/02/2023.
//

import Combine
import Foundation

public protocol MoviesRepositoryProtocol: AnyObject {

    func get() async throws -> MoviesDTO
    func getEpisode(episodeId: Int) async throws -> MovieDTO
    func setFavorite(episodesId: [String])
    func getFavorites() async throws -> [String]
}

public final class MoviesRepository: MoviesRepositoryProtocol {

    // MARK: Singleton

    public static let shared = MoviesRepository()

    // MARK: Properties

    private let localDataSource: MoviesLocalDataSourceProtocol
    private let remoteDataSource: MoviesRemoteDataSourceProtocol
    private var cancellables = Set<AnyCancellable>()

    // MARK: Init

    init(
        remoteDataSource: MoviesRemoteDataSourceProtocol = MoviesRemoteDataSource(),
        localDataSource: MoviesLocalDataSourceProtocol = MoviesLocalDataSource()
    ) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }

    // MARK: MoviesRepositoryProtocol

    public func get() async throws -> MoviesDTO {
        try await remoteDataSource.get()
    }
    
    public func getEpisode(episodeId: Int) async throws -> MovieDTO {
        try await remoteDataSource.getEpisode(episodeId: episodeId)
    }

    public func setFavorite(episodesId: [String]) {
        localDataSource.setFavorite(episodesId: episodesId)
    }

    public func getFavorites() async throws -> [String] {
        try await localDataSource.getFavorites()
    }
}
