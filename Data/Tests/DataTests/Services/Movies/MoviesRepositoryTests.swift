//
//  MoviesRepositoryTests.swift
//  
//
//  Created by Quentin Varlet on 10/03/2023.
//

@testable import Data
import XCTest

// swiftlint:disable:file implicitly_unwrapped_optional

final class MoviesRepositoryTests: XCTestCase {

    // MARK: Properties

    private var remoteDataSource: MockMoviesRemoteDataSource!
    private var sut: MoviesRepository!

    // MARK: XCTestCase

    override func setUp() async throws {
        try await super.setUp()

        remoteDataSource = MockMoviesRemoteDataSource()
        sut = MoviesRepository(remoteDataSource: remoteDataSource)
    }

    override func tearDown() async throws {
        try await super.tearDown()

        remoteDataSource = nil
        sut = nil
    }

    // MARK: Tests

    func testGetMovies() async throws {

        let response = try await sut.get()

        XCTAssertTrue(remoteDataSource.getMovies)

        XCTAssertEqual(
            remoteDataSource.mockMoviesResponseDTO,
            response
        )
    }
}
