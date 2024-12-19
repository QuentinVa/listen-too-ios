//
//  Logger.swift
//  
//
//  Created by Quentin Varlet on 19/12/2024.
//

import os

public protocol LoggerProtocol: Sendable {

    func debug(_ message: String, file: String, function: String, line: Int)
    func info(_ message: String, file: String, function: String, line: Int)
    func error(_ error: Error, file: String, function: String, line: Int)
}

public final class Logger: LoggerProtocol {

    // MARK: Properties

    private let logger: os.Logger

    // MARK: Init

    public init(category: String) {
        self.logger = os.Logger(
            subsystem: "com.listentoo.store",
            category: category
        )
    }

    // MARK: LoggerProtocol

    public func debug(_ message: String, file: String, function: String, line: Int) {
        let message = "DEBUG: \(file) line \(line) in \(function):\(message)"
        logger.debug("\(message)")
    }

    public func info(_ message: String, file: String, function: String, line: Int) {
        let message = "INFO: \(file) line \(line) in \(function): \(message)"
        logger.info("\(message)")
    }

    public func error(_ error: Error, file: String, function: String, line: Int) {
        let message = "ERROR: \(file) line \(line) in \(function): \(error)"
        logger.error("\(message)")
    }
}
