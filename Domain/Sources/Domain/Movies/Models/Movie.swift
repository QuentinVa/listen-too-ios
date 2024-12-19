//
//  Movie.swift
//  
//
//  Created by Quentin Varlet on 01/03/2023.
//

import Foundation

public struct Movie: Equatable, Hashable {

    // MARK: Properties

    public let title: String
    public let episodeId: Int
    public let openingCrawl: String
    public let director: String
    public let producer: String
    public let releaseDate: String?
    public let characters: [String]
    public let planets: [String]
    public let starships: [String]
    public let vehicles: [String]
    public let species: [String]
    public let created: String?
    public let edited: String?
    public let url: URL?
}
