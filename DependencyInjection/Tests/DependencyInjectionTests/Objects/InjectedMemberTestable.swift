//
//  InjectedMemberTestableProtocol.swift
//  DependencyInjection
//
//  Created by JC Neboit on 02/10/2024.
//

import DependencyInjection

protocol InjectedMemberTestableProtocol {

    func noop()
}

@InjectedMember(\.someInjectableObject)
final class InjectedMemberTestable: InjectedMemberTestableProtocol {

    func noop() {
        someInjectableObject.noop()
    }
}

extension InjectedValues {

    @Inject var injectedMemberTestable: InjectedMemberTestableProtocol = InjectedMemberTestable()
}
