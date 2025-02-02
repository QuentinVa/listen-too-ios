//
//  Request.swift
//  
//
//  Created by Quentin Varlet on 28/02/2023.
//

import Foundation

protocol Request {

    var url: String { get }

    func params() -> [(key: String, value: String)]
}

struct SwapiApi {

    struct SearchSwapiRequest: Request {

        // MARK: Properties

        let baseUrl = "https://swapi.dev/api/"
        let apiKey = ""

        var path: String
        var url: String { baseUrl + path }

        // MARK: Methods

        func params() -> [(key: String, value: String)] {
            [(key: "api_key", value: apiKey)]
        }
    }

    // MARK: Private methods

    private func parse(_ data: Foundation.Data) throws -> MoviesDTO {
        let response: MoviesDTO = try JSONDecoder().decode(MoviesDTO.self, from: data)
        return response
    }
}
