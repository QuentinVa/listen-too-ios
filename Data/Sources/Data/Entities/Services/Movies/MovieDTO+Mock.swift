//
//  MovieDTO+Mock.swift
//  Data
//
//  Created by Quentin Varlet on 29/01/2025.
//

import Foundation

// swiftlint:disable
extension MovieDTO {

    public static let dummy = MovieDTO(
        title: "Title",
        episodeId: 1,
        openingCrawl: "Blablabla",
        director: "George Lucas",
        producer: "Producer",
        releaseDate: "ReleaseDate",
        characters: ["Characters"],
        planets: ["Planets"],
        starships: ["Startship"],
        vehicles: ["Vehicles"],
        species: ["Species"],
        created: "Created",
        edited: "Edited",
        url: URL(string: "https://")!
    )

    public static let dummy2 = MovieDTO(
        title: "Title 2",
        episodeId: 2,
        openingCrawl: "Blablabla",
        director: "Irvin Kershner",
        producer: "Producer",
        releaseDate: "ReleaseDate",
        characters: ["Characters"],
        planets: ["Planets"],
        starships: ["Startship"],
        vehicles: ["Vehicles"],
        species: ["Species"],
        created: "Created",
        edited: "Edited",
        url: URL(string: "https://")!
    )

    public static let dummy3 = MovieDTO(
        title: "Title 3",
        episodeId: 3,
        openingCrawl: "Blablabla",
        director: "Irvin Kershner",
        producer: "Producer",
        releaseDate: "ReleaseDate",
        characters: ["Characters"],
        planets: ["Planets"],
        starships: ["Startship"],
        vehicles: ["Vehicles"],
        species: ["Species"],
        created: "Created",
        edited: "Edited",
        url: URL(string: "https://")!
    )

    public static let dummies = [dummy, dummy2, dummy3]
}
