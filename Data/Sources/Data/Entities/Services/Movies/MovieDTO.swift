//
//  MovieDTO.swift
//  
//
//  Created by Quentin Varlet on 28/02/2023.
//

import Foundation

public struct MovieDTO: Equatable, Decodable, Hashable {

    // MARK: Properties

    public let title: String
    public let episodeId: Int
    public let openingCrawl: String
    public let director: String
    public let producer: String
    public let releaseDate: String
    public let characters: [String]
    public let planets: [String]
    public let starships: [String]
    public let vehicles: [String]
    public let species: [String]
    public let created: String
    public let edited: String
    public let url: URL

    // MARK: Init

    // swiftlint:disable:next line_length
    public init(title: String, episodeId: Int, openingCrawl: String, director: String, producer: String, releaseDate: String, characters: [String], planets: [String], starships: [String], vehicles: [String], species: [String], created: String, edited: String, url: URL) {
        self.title = title
        self.episodeId = episodeId
        self.openingCrawl = openingCrawl
        self.director = director
        self.producer = producer
        self.releaseDate = releaseDate
        self.characters = characters
        self.planets = planets
        self.starships = starships
        self.vehicles = vehicles
        self.species = species
        self.created = created
        self.edited = edited
        self.url = url
    }

    // MARK: Decodable

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        episodeId = try container.decode(Int.self, forKey: .episodeId)
        openingCrawl = try container.decode(String.self, forKey: .openingCrawl)
        director = try container.decode(String.self, forKey: .director)
        producer = try container.decode(String.self, forKey: .producer)
        releaseDate = try container.decode(String.self, forKey: .releaseDate)
        characters = try container.decode([String].self, forKey: .characters)
        planets = try container.decode([String].self, forKey: .planets)
        starships = try container.decode([String].self, forKey: .starships)
        vehicles = try container.decode([String].self, forKey: .vehicles)
        species = try container.decode([String].self, forKey: .species)
        created = try container.decode(String.self, forKey: .created)
        edited = try container.decode(String.self, forKey: .edited)
        url = try container.decode(URL.self, forKey: .url)
    }

    // MARK: Hashable

    enum CodingKeys: String, CodingKey {
        case title, director, producer, characters, planets, starships, vehicles, species, created, edited, url
        case episodeId = "episode_id"
        case openingCrawl = "opening_crawl"
        case releaseDate = "release_date"
    }
}
