//
//  MockRecordNonFatalErrorUseCase.swift
//  Logger
//
//  Created by Quentin Varlet on 19/12/2024.
//

final class MockRecordNonFatalErrorUseCase: @unchecked Sendable {

    // MARK: Properties

    var recordedErrors: [Error] = []

    // MARK: RecordNonFatalErrorUseCaseProtocol

    func perform(_ error: Error) {
        recordedErrors.append(error)
    }
}
