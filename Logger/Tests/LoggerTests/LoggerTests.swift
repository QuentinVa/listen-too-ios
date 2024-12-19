//
//  LoggerTests.swift
//  Logger
//
//  Created by Quentin Varlet on 19/12/2024.
//

import DependencyInjection
@testable import Logger
import Testing

// swiftlint:disable force_unwrapping
// swiftlint:disable force_cast

struct LoggerTests {

    // MARK: SampleError

    enum SampleError: Error {

        case testFailure
    }

    // MARK: Properties

    private let sut: Logger
    private let recordLogUseCase: MockRecordLogUseCase
    private let recordNonFatalErrorUseCase: MockRecordNonFatalErrorUseCase
    private let setCrashReporterUserIdUseCase: MockSetCrashReporterUserIdUseCase

    // MARK: Init

    init() {
        let recordLogUseCase = MockRecordLogUseCase()
        self.recordLogUseCase = recordLogUseCase

        let recordNonFatalErrorUseCase = MockRecordNonFatalErrorUseCase()
        self.recordNonFatalErrorUseCase = recordNonFatalErrorUseCase

        let setCrashReporterUserIdUseCase = MockSetCrashReporterUserIdUseCase()
        self.setCrashReporterUserIdUseCase = setCrashReporterUserIdUseCase

        sut = withSafeConcurrencyInjections {
            return Logger(category: "LoggerTests")
        }
    }

    // MARK: Tests

    @Test
    func debug() {
        // Cannot test console printing
        sut.debug("message")
    }

    @Test
    func info() {
        // Given
        recordLogUseCase.loggedMessages = []
        let message = "message"

        // When
        sut.info(message)

        // Then
        #expect(recordLogUseCase.loggedMessages.count == 1)
        #expect(recordLogUseCase.loggedMessages.first! == "INFO: LoggerTests/LoggerTests.swift line 80 in info(): \(message)")
    }

    @Test
    func error() {
        // Given
        recordLogUseCase.loggedMessages = []

        // When
        sut.error(SampleError.testFailure)

        // Then
        #expect(recordLogUseCase.loggedMessages.count == 1)
        #expect(recordLogUseCase.loggedMessages.first! == "ERROR: LoggerTests/LoggerTests.swift line 93 in error(): testFailure")
        #expect(recordNonFatalErrorUseCase.recordedErrors.count == 1)
        #expect(recordNonFatalErrorUseCase.recordedErrors.first as! SampleError == SampleError.testFailure)
    }
}
