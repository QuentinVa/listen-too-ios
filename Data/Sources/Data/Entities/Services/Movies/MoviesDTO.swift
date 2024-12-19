//
//  MoviesDTO.swift
//  
//
//  Created by Quentin Varlet on 28/02/2023.
//

import Foundation

public struct MoviesDTO: Decodable, Equatable {

    // MARK: Properties

    public var count: Int
    public var next: Int?
    public var preview: Int?
    public var results: [MovieDTO]

    // MARK: Init

    public init(
        count: Int,
        next: Int?,
        preview: Int?,
        results: [MovieDTO]
    ) {
        self.count = count
        self.next = next ?? 0
        self.preview = preview ?? 0
        self.results = results
    }
}
