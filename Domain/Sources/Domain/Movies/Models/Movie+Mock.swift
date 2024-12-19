//
//  Movie+Mock.swift
//  Domain
//
//  Created by Quentin Varlet on 29/01/2025.
//

import Foundation

// swiftlint:disable:next no_grouping_extension
extension Movie {

    // swiftlint:disable:next line_length no_magic_numbers superfluous_disable_command
    public static let dummy = Movie(
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
        url: URL(string: "https://")
    )

    // swiftlint:disable:next line_length no_magic_numbers
    public static let dummy2 = Movie(
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
        url: URL(string: "https://")
    )

    // swiftlint:disable:next line_length no_magic_numbers
    public static let dummy3 = Movie(
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
        url: URL(string: "https://")
    )

    public static let dummies = [dummy, dummy2, dummy3]
}
