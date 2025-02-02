// swiftlint:disable:this file_name
//
//  LoggerProtocol+Defaults.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

// Need this extension to define defaults
extension LoggerProtocol {

    public func debug(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        self.debug(message, file: file, function: function, line: line)
    }

    public func info(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
        self.info(message, file: file, function: function, line: line)
    }

    public func error(_ error: Error, file: String = #file, function: String = #function, line: Int = #line) {
        self.error(error, file: file, function: function, line: line)
    }
}
