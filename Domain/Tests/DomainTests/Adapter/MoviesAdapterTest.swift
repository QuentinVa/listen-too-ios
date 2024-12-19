//
//  MoviesAdapterTest.swift
//  
//
//  Created by Quentin Varlet on 10/03/2023.
//

import Data
@testable import Domain
import XCTest

// swiftlint:disable:file implicitly_unwrapped_optional no_magic_numbers

final class MoviesAdapterTest: XCTestCase {

    // MARK: Data

    let movieResponseDTO = MoviesDTO(
        count: 3,
        next: 3,
        preview: 1,
        results: MovieDTO.dummies
    )

    private let movie = Movies(
        count: 3,
        next: 3,
        preview: 1,
        results: Movie.dummies
    )

    // MARK: Properties

    private var sut: MovieAdapter!

    // MARK: XCTestCase

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()

        sut = nil
    }

    // MARK: Tests

    func testConvertUserResponseDTOToUser() {
        XCTAssertEqual(
            MovieAdapter.movie(from: movieResponseDTO.results),
            movie.results
        )
    }
}
