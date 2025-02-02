//
//  SomeInjectableWrappedConsumer.swift
//  DependencyInjection
//
//  Created by Richard Bergoin on 24/09/2024.
//

import DependencyInjection

final class SomeInjectableWrappedConsumer {

    @Injected(\.someInjectableObject)
    var someInjectableObject

    func useInjectedObjectTwice() {
        // use multiple time the toBeInjected var, and check if not recreated
        someInjectableObject.noop()
        someInjectableObject.noop()
    }
}
