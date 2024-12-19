//
//  MockRecordLogUseCase.swift
//  Logger
//
//  Created by Quentin Varlet on 19/12/2024.
//

final class MockRecordLogUseCase: @unchecked Sendable {

    // MARK: Properties

    var loggedMessages: [String] = []

    // MARK: RecordLogUseCaseProtocol

    func perform(message: String) {
        loggedMessages.append(message)
    }
}
