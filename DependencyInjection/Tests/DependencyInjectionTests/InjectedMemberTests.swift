//
//  InjectedMemberTests.swift
//  DependencyInjection
//
//  Created by Richard Bergoin on 12/09/2024.
//

@testable import DependencyInjection
import XCTest

// swiftlint:disable implicitly_unwrapped_optional

final class InjectedMemberTests: XCTestCase {

    private var mockSomeInjectable: MockSomeInjectableObject!
    private var sut: SomeInjectableConsumer!

    // MARK: XCTestCase

    override func setUp() {
        super.setUp()

        mockSomeInjectable = MockSomeInjectableObject()
        sut = withSafeConcurrencyInjections {
            InjectedValues.inject(someInjectableObject: self.mockSomeInjectable)
            return SomeInjectableConsumer()
        }
    }

    override func tearDown() {
        super.tearDown()

        sut = nil
        mockSomeInjectable = nil
    }

    // MARK: Tests

    func testMockManipulation() async throws {
        // Given
        let initialNoopCallCount = mockSomeInjectable.noopCallCount
        mockSomeInjectable.noopCallCount = 12

        // When
        sut.useInjectedObjectTwice()

        // Then
        XCTAssertEqual(initialNoopCallCount, 0)
        XCTAssertEqual(mockSomeInjectable.noopCallCount, 12 + 2)
    }

    func testMockManipulationBis() async throws {
        // Given
        let initialNoopCallCount = mockSomeInjectable.noopCallCount
        mockSomeInjectable.noopCallCount = 14

        // When
        sut.useInjectedObjectTwice()

        // Then
        XCTAssertEqual(initialNoopCallCount, 0)
        XCTAssertEqual(mockSomeInjectable.noopCallCount, 14 + 2)
    }
}
