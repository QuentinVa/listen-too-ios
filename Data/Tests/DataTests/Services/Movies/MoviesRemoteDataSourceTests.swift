//
//  MoviesRemoteDataSourceTests.swift
//  
//
//  Created by Quentin Varlet on 09/03/2023.
//

@testable import Data
import XCTest

// swiftlint:disable:file force_unwrapping
// swiftlint:disable:file implicitly_unwrapped_optional
final class MoviesRemoteDataSourceTests: XCTestCase {

    // MARK: Properties

    private var network: MockNetwork!
    private var sut: MoviesRemoteDataSource!

    // MARK: XCTestCase

    override func setUp() async throws {
        try await super.setUp()

        network = MockNetwork()
        sut = MoviesRemoteDataSource(network: network)
    }

    override func tearDown() async throws {
        try await super.tearDown()

        network = nil
        sut = nil
    }

    // MARK: Tests

    func testGetMovies() async throws {
        network.jsonResourceName = "mock-movie-response-dto"

        _ = try await sut.get()

        // Network
        XCTAssertTrue(network.loadCalled)

        // Router
        XCTAssertTrue(network.request!.url!.absoluteString.hasSuffix("/films"))
        XCTAssertEqual(network.request!.httpMethod, "GET")
        XCTAssertNil(network.request!.allHTTPHeaderFields!["content-type"])
        XCTAssertNil(network.request!.httpBody)
    }
}
