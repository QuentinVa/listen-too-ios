//
//  Movies.swift
//  
//
//  Created by Quentin Varlet on 01/03/2023.
//

public struct Movies: Equatable {

    // MARK: Properties

    public var count: Int
    public var next: Int?
    public var preview: Int?
    public var results: [Movie]
}
