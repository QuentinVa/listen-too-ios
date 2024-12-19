//
//  AnotherInjectableObject.swift
//  DependencyInjection
//
//  Created by Richard Bergoin on 06/09/2024.
//

import DependencyInjection

protocol AnotherInjectableObjectProtocol {}

class TwiceInjectableObject: AnotherInjectableObjectProtocol {}

class AnotherInjectableObject: AnotherInjectableObjectProtocol {}

extension InjectedValues {

    @Inject var anotherInjectableObject: AnotherInjectableObjectProtocol = AnotherInjectableObject()
    @Inject var twiceInjectableObject: AnotherInjectableObjectProtocol = TwiceInjectableObject()
}
