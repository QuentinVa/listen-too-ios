//
//  SomeInjectableConsumer.swift
//  DependencyInjection
//
//  Created by Richard Bergoin on 24/09/2024.
//

import DependencyInjection

@InjectedMember(\.someInjectableObject)
@InjectedMember(\.anotherInjectableObject, protocol: AnotherInjectableObjectProtocol)
final class SomeInjectableConsumer {

    func useInjectedObjectTwice() {
        // use multiple time the toBeInjected var, and check if not recreated
        someInjectableObject.noop()
        someInjectableObject.noop()
    }
}
