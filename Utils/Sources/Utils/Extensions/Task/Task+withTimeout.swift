//
//  Task+withTimeout.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

public import Foundation

struct TimedOutError: Error, Equatable {}

extension Task {
    ///
    /// Execute an operation in the current task subject to a timeout.
    ///
    /// - Parameters:
    ///   - seconds: The duration in seconds `operation` is allowed to run before timing out.
    ///   - operation: The async operation to perform.
    /// - Returns: Returns the result of `operation` if it completed in time.
    /// - Throws: Throws ``TimedOutError`` if the timeout expires before `operation` completes.
    ///   If `operation` throws an error before the timeout expires, that error is propagated to the caller.
    public static func withTimeout<R>(
        seconds: TimeInterval,
        operation: @escaping @Sendable () async throws -> R,
        onCancel: @escaping @Sendable () -> Void
    ) async throws -> R where R: Sendable {
        try await withThrowingTaskGroup(of: R.self) { group in
            // Start actual work.
            group.addTask {
                try await withTaskCancellationHandler(
                    operation: {
                        let result = try await operation()
                        try Task<Never, Never>.checkCancellation()
                        return result
                    },
                    onCancel: {
                        onCancel()
                    }
                )
            }

            // Start timeout child task.
            group.addTask {
                try await Task<Never, Never>.sleep(nanoseconds: UInt64(seconds * Double(NSEC_PER_SEC)))
                try Task<Never, Never>.checkCancellation()
                // We’ve reached the timeout.
                throw TimedOutError()
            }

            // First finished child task wins, cancel the other task.
            let result = try await group.next()
            group.cancelAll()

            if let result {
                return result
            } else {
                throw TimedOutError()
            }
        }
    }
}
