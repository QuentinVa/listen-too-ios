//
//  SomeInjectableObject.swift
//  DependencyInjection
//
//  Created by Richard Bergoin on 06/09/2024.
//

import DependencyInjection

// swiftlint:disable file_types_order

protocol SomeInjectableObjectProtocol {

    func noop()
}

actor SomeInjectableObject: SomeInjectableObjectProtocol {

    static var aliveInstanciationsCount = 0

    init() {
        Self.aliveInstanciationsCount += 1
    }

    // swiftlint:disable:next type_contents_order
    deinit { // swiftlint:disable:this forbidden_use_deinit
        Self.aliveInstanciationsCount -= 1
    }

    nonisolated func noop() {}
}

class MockSomeInjectableObject: SomeInjectableObjectProtocol {

    var noopCallCount = 0

    func noop() {
        noopCallCount += 1
    }
}

extension InjectedValues {

    @Inject var someInjectableObject: SomeInjectableObjectProtocol = SomeInjectableObject()
}
