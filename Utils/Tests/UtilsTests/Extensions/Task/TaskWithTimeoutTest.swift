//
//  TaskWithTimeoutTest.swift.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Testing

// swiftlint:disable no_magic_numbers

struct TaskWithTimeoutTest {

    // MARK: Tests

    @Test
    func testTask() async throws {
        await confirmation("The task should execute") { executeConfirmation in
            // Given
            // Nothing

            // When
            do {
                try await Task<Never, Never>.withTimeout(
                    seconds: 2,
                    operation: {
                        try await Task.sleep(seconds: 0.01)
                        // Then
                        executeConfirmation()
                    },
                    onCancel: {
                        Issue.record("The task should not call cancel")
                    }
                )
            } catch {
                Issue.record("The task should not timeout")
            }
        }
    }

    @Test
    func testTaskTimedOut() async throws {
        await confirmation("The task should execute") { timeoutConfirmation in
            await confirmation("The task should call cancel") { cancelConfirmation in
                // Given
                // Nothing

                // When
                do {
                    try await Task<Never, Never>.withTimeout(
                        seconds: 0.01,
                        operation: {
                            try await Task.sleep(seconds: 1)
                            Issue.record("The task should not execute")
                        },
                        onCancel: {
                            cancelConfirmation()
                        }
                    )
                } catch {
                    timeoutConfirmation()
                }
            }
        }
    }

    @Test
    func testTaskCancelation() async throws {
        try await confirmation("The task should cancel") { cancelConfirmation in
            // Given
            // Nothing

            // When
            try await withThrowingTaskGroup(of: Void.self) { group in
                group.addTask {
                    try await Task<Never, Never>.withTimeout(
                        seconds: 0.05,
                        operation: {
                            try await Task.sleep(seconds: 1)
                            try Task.checkCancellation()
                            Issue.record("The task should not execute")
                        },
                        onCancel: {
                            cancelConfirmation()
                        }
                    )
                }
                // Sleep here to let Task management to
                try await Task.sleep(seconds: 0.01)
                group.cancelAll()
            }
        }
    }
}
