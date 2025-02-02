//
//  MovieAdapter.swift
//  
//
//  Created by Quentin Varlet on 02/03/2023.
//

import Data

protocol MovieAdapterProtocol {

    associatedtype Input
    associatedtype Output

    func movies(from responseDTO: [MovieDTO]) -> [Movie]
    func movie(from object: Input) -> Output
}


struct MovieAdapter: MovieAdapterProtocol {
    
    typealias Input = MovieDTO
    typealias Output = Movie

    func movies(from responseDTO: [MovieDTO]) -> [Movie] {

        var movieArray: [Movie] = []
        responseDTO.forEach({ movie in
            let value = Movie(
                title: movie.title,
                episodeId: movie.episodeId,
                openingCrawl: movie.openingCrawl,
                director: movie.director,
                producer: movie.producer,
                releaseDate: movie.releaseDate,
                characters: movie.characters,
                planets: movie.planets,
                starships: movie.starships,
                vehicles: movie.vehicles,
                species: movie.species,
                created: movie.created,
                edited: movie.edited,
                url: movie.url
            )
            movieArray.append(value)
        })
        return movieArray
    }
    
    func movie(from responseDTO: MovieDTO) -> Movie {
        .init(
            title: responseDTO.title,
            episodeId: responseDTO.episodeId,
            openingCrawl: responseDTO.openingCrawl,
            director: responseDTO.director,
            producer: responseDTO.producer,
            releaseDate: responseDTO.releaseDate,
            characters: responseDTO.characters,
            planets: responseDTO.planets,
            starships: responseDTO.starships,
            vehicles: responseDTO.vehicles,
            species: responseDTO.species,
            created: responseDTO.created,
            edited: responseDTO.edited,
            url: responseDTO.url
        )
    }
}
