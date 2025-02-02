//
//  GetMoviesUseCaseTests.swift
//  
//
//  Created by Quentin Varlet on 10/03/2023.
//

import Data
@testable import Domain
import XCTest

// swiftlint:disable:file implicitly_unwrapped_optional
// swiftlint:disable:file untyped_error_in_catch

final class GetMoviesUseCaseTests: XCTestCase {

    // MARK: Properties

    private var moviesRepository: MockMoviesRepository!
    private var sut: GetMoviesUseCaseProtocol!

    // MARK: XCTestCase

    override func setUp() async throws {
        try await super.setUp()

        moviesRepository = MockMoviesRepository()

        sut = GetMoviesUseCase(
            moviesRepository: moviesRepository
        )
    }

    override func tearDown() async throws {
        try await super.tearDown()

        moviesRepository = nil

        sut = nil
    }

    // MARK: Tests

    func testGoodGetMovies() async throws {
        let movie = try await sut.perform()

        XCTAssertTrue(moviesRepository.getMovies)

        XCTAssertEqual(
            movie,
            Movies(
                count: moviesRepository.mockMoviesResponseDTO.count,
                results: MovieAdapter.movie(from: moviesRepository.mockMoviesResponseDTO.results)
            )
        )
    }

    func testWrongGetMovies() async throws {
        do {
            _ = try await sut.perform()
            XCTFail("Shouldn't succeed")
        } catch let error {
            XCTFail("Shouldn't trigger \(error), should be GetMoviesUseCase.Error")
        }
    }
}
