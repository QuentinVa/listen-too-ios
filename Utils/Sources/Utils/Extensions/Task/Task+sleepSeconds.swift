//
//  Task+sleepSeconds.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

public import Foundation

extension Task where Success == Never, Failure == Never {

    public static func sleep(seconds: TimeInterval) async throws {
        let secondToNanosecondsMultiplier: TimeInterval = 1_000_000_000

        try await Task.sleep(nanoseconds: UInt64(seconds * secondToNanosecondsMultiplier))
    }
}
