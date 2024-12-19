//
//  MoviesRouter.swift
//  
//
//  Created by Quentin Varlet on 28/02/2023.
//

import Foundation

protocol MoviesRouterProtocol: AnyObject {

    func getMovies() throws -> URLRequest
    func getEpisode(episodeId: Int) throws -> URLRequest
}

protocol MoviesOutputProtocol: AnyObject {

    func moviesFetchedSuccessfully(movies: MoviesDTO) -> MoviesDTO
    func moviesFetchingFailed(error: Error) -> Error
}

final class MoviesRouter: Router, MoviesRouterProtocol {

    // MARK: MoviesRouterProtocol

    func getMovies() throws -> URLRequest {
        let request = SwapiApi.SearchSwapiRequest(path: "films")
        return try urlRequest(httpMethod: .get, request: request)
    }
    
    func getEpisode(episodeId: Int) throws -> URLRequest {
        let request = SwapiApi.SearchSwapiRequest(path: "films/\(episodeId)")
        return try urlRequest(httpMethod: .get, request: request)
    }
}
