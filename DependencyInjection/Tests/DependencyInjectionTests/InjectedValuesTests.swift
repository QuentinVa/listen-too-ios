//
//  InjectedValuesTests.swift
//  DependencyInjection
//
//  Created by Richard Bergoin on 03/09/2024.
//

@testable import DependencyInjection
import Testing

struct InjectedValuesTests {

    // MARK: Tests

    @Test
    func testInitOfInjectedItemIsCalledOnceAndDeallocated() async throws {
        withSafeConcurrencyInjections { // needed for the whole test, because of aliveInstanciationsCount that is static
            // Given
            let initialNumberOfInstanciations = SomeInjectableObject.aliveInstanciationsCount
            typealias sut = InjectedValues // swiftlint:disable:this type_name

            // When
            var someInjectable: SomeInjectableObjectProtocol? = sut[\.someInjectableObject]
            let currentNumberOfInstanciations = SomeInjectableObject.aliveInstanciationsCount
            someInjectable?.noop()
            someInjectable = nil

            // Then
            #expect(initialNumberOfInstanciations == 0)
            #expect(currentNumberOfInstanciations == 1)
            #expect(SomeInjectableObject.aliveInstanciationsCount == 0)
        }
    }

    @Test
    func testInitOfInjectedItemIsCalledOnceFromUserObjectAndDeallocated() async throws {
        withSafeConcurrencyInjections { // needed for the whole test, because of aliveInstanciationsCount that is static
            // Given
            let initialNumberOfInstanciations = SomeInjectableObject.aliveInstanciationsCount

            // When
            var injectableConsumer: SomeInjectableConsumer? = SomeInjectableConsumer() // uses the ToBeInjected instance
            injectableConsumer?.useInjectedObjectTwice()
            let currentNumberOfInstanciations = SomeInjectableObject.aliveInstanciationsCount

            // Then
            #expect(initialNumberOfInstanciations == 0)
            #expect(currentNumberOfInstanciations == 1)
            injectableConsumer = nil
            #expect(SomeInjectableObject.aliveInstanciationsCount == 0)
        }
    }

    @Test
    func testNoDefaultInjectedItemIsCalled() async throws {
        withSafeConcurrencyInjections { // needed for the whole test, because of aliveInstanciationsCount that is static
            // Given
            let initialNumberOfInstanciations = SomeInjectableObject.aliveInstanciationsCount

            // When
            InjectedValues.inject(someInjectableObject: MockSomeInjectableObject())
            let injectableConsumer = SomeInjectableConsumer() // uses the MockToBeInjected instance
            injectableConsumer.useInjectedObjectTwice()
            let currentNumberOfInstanciations = SomeInjectableObject.aliveInstanciationsCount

            // Then
            #expect(initialNumberOfInstanciations == 0)
            #expect(currentNumberOfInstanciations == 0)
        }
    }

    @Test
    func testInitOfInjectedItemIsCalledMultipleTimes() async throws {
        withSafeConcurrencyInjections { // needed for the whole test, because of aliveInstanciationsCount that is static
            // Given
            let initialNumberOfInstanciations = SomeInjectableObject.aliveInstanciationsCount

            // When
            InjectedValues.inject(someInjectableObject: MockSomeInjectableObject())
            let injectableConsumer = SomeInjectableConsumer() // uses the MockToBeInjected instance
            injectableConsumer.useInjectedObjectTwice()
            let injectableConsumer2 = SomeInjectableConsumer() // uses the ToBeInjected instance
            injectableConsumer2.useInjectedObjectTwice()
            let currentNumberOfInstanciations = SomeInjectableObject.aliveInstanciationsCount

            // Then
            #expect(initialNumberOfInstanciations == 0)
            #expect(currentNumberOfInstanciations == 1)
        }
    }

    @Test
    func testInjectMultipleTimes() async throws {
        withSafeConcurrencyInjections { // needed for the whole test, because of aliveInstanciationsCount that is static
            // Given
            let initialNumberOfInstanciations = SomeInjectableObject.aliveInstanciationsCount
            final class DaughterOfMockSomeInjectableObject: MockSomeInjectableObject {}

            // When
            let injectionCountForTwoConsumers: UInt = 2
            InjectedValues.inject(someInjectableObject: MockSomeInjectableObject(), count: injectionCountForTwoConsumers)
            InjectedValues.inject(someInjectableObject: DaughterOfMockSomeInjectableObject())
            let injectableConsumer = SomeInjectableConsumer() // uses the DaughterOfMockSomeInjectableObject instance
            injectableConsumer.useInjectedObjectTwice()
            let injectableConsumerBis = SomeInjectableConsumer() // uses the MockToBeInjected instance
            injectableConsumerBis.useInjectedObjectTwice()
            let injectableConsumer2 = SomeInjectableConsumer() // uses the MockToBeInjected instance
            injectableConsumer2.useInjectedObjectTwice()
            let currentNumberOfInstanciations = SomeInjectableObject.aliveInstanciationsCount

            // Then
            #expect(initialNumberOfInstanciations == 0)
            #expect(currentNumberOfInstanciations == 0)
        }
    }
}
