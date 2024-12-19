//
//  InjectedValuesActor.swift
//  DependencyInjection
//
//  Created by Richard Bergoin on 25/09/2024.
//

import Foundation

public actor InjectedValuesActor {

    // MARK: Private properties

    private static var isRunningTests = {
        Bundle.main.bundleIdentifier == "com.apple.dt.xctest.tool"
    }()

    private static let queueKey = DispatchSpecificKey<Void>()
    private static let queue: DispatchQueue = {
        let queue = DispatchQueue(label: "dependency.injection.safeConcurrency")
        queue.setSpecific(key: queueKey, value: ())
        return queue
    }()

    // MARK: Public methods

    public static func withSafeConcurrencyInjections<T>(_ injections: () -> T) -> T {
        if isOnSafeConcurrencyInjectionsQueue() {
            injections()
        } else {
            queue.sync {
                injections()
            }
        }
    }

    public static func isOnSafeConcurrencyInjectionsQueue() -> Bool {
        DispatchQueue.getSpecific(key: queueKey) != nil
    }
}

/// The closure `injections` will garantee that injected objects will be "consumed" within the same block
public func withSafeConcurrencyInjections<T>(_ injections: () -> T) -> T {
    InjectedValuesActor.withSafeConcurrencyInjections(injections)
}
