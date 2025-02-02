//
//  MockSetCrashReporterUserIdUseCase.swift
//  Logger
//
//  Created by Quentin Varlet on 19/12/2024.
//

final class MockSetCrashReporterUserIdUseCase: @unchecked Sendable {

    // MARK: Properties

    var userId: String?

    // MARK: SetCrashReporterUserIdUseCaseProtocol

    func perform(_ userId: String?) {
        self.userId = userId
    }
}
