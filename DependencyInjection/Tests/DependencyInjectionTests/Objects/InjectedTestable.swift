//
//  InjectedTestableProtocol.swift
//  DependencyInjection
//
//  Created by JC Neboit on 02/10/2024.
//

import DependencyInjection

protocol InjectedTestableProtocol {

    func noop()
}

final class InjectedTestable: InjectedTestableProtocol {

    @Injected(\.someInjectableObject)
    var someInjectableObject

    func noop() {
        someInjectableObject.noop()
    }
}

extension InjectedValues {

    @Inject var injectedTestable: InjectedTestableProtocol = InjectedTestable()
}
