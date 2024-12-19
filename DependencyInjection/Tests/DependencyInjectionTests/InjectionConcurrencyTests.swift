//
//  InjectionConcurrencyTests.swift
//  DependencyInjection
//
//  Created by Quentin Varlet on 19/12/2024.
//

// swiftlint:disable force_cast no_magic_numbers

import DependencyInjection
import Testing

struct InjectionConcurrencyTests {

    @InjectedMember(\.injectedMemberTestable)
    final class SomeInjectedMemberViewModel {

        func noop() {
            injectedMemberTestable.noop()
        }
    }

    final class SomeInjectedViewModel {

        @Injected(\.injectedTestable)
        var injectedTestable

        func noop() {
            injectedTestable.noop()
        }
    }

    @Test(arguments: 1...300)
    func testInjectedMemberConcurrentsInjection(count: Int) async throws {
        // Given
        let someInjectableObject = MockSomeInjectableObject()
        let sut: SomeInjectedMemberViewModel = withSafeConcurrencyInjections {
            InjectedValues.inject(someInjectableObject: someInjectableObject)
            return SomeInjectedMemberViewModel()
        }

        // When
        sut.noop()

        // Then
        #expect(someInjectableObject.noopCallCount == 1)
    }

    @Test(arguments: 1...300)
    func testInjectedConcurrentsInjection(count: Int) async throws {
        // Given
        let someInjectableObject = MockSomeInjectableObject()
        let sut: SomeInjectedViewModel = withSafeConcurrencyInjections {
            InjectedValues.inject(someInjectableObject: someInjectableObject)
            let sut = SomeInjectedViewModel()
            _ = (sut.injectedTestable as! InjectedTestable).someInjectableObject
            return sut
        }

        // When
        sut.noop()

        // Then
        #expect(someInjectableObject.noopCallCount == 1)

        let expectedSomeInjectableObject = (sut.injectedTestable as! InjectedTestable).someInjectableObject as! MockSomeInjectableObject
        #expect(someInjectableObject === expectedSomeInjectableObject)
    }
}
