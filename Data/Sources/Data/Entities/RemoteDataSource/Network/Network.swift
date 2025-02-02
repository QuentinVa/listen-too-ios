//
//  Network.swift
//  
//
//  Created by Quentin Varlet on 28/02/2023.
//

import Foundation
import Logger
import os

protocol NetworkProtocol: AnyObject {

    var decoder: JSONDecoder { get }

    func load(request: URLRequest) async throws -> Foundation.Data
    func load<T: Decodable>(request: URLRequest) async throws -> T
}

final class Network: NetworkProtocol {

    // MARK: Properties

    let decoder: JSONDecoder
    let logger = Logger(category: "Data Network")

    // MARK: Init

    init(
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys
    ) {
        self.decoder = JSONDecoder()
        self.decoder.keyDecodingStrategy = keyDecodingStrategy
    }

    // MARK: NetworkProtocol

    @discardableResult
    func load(request: URLRequest) async throws -> Foundation.Data {
        logger.info("\(self.log(request: request))")

        let (data, response) = try await URLSession.shared.data(for: request)
        logger.info("\(self.log(data: data, response: response))")

        try ensureResponseIsValid(response: response)

        return data
    }

    func load<T: Decodable>(request: URLRequest) async throws -> T {
        let data = try await load(request: request)
        return try decoder.decode(T.self, from: data)
    }

    // MARK: Private methods

    private func ensureResponseIsValid(response: URLResponse) throws {
        guard let response = response as? HTTPURLResponse
        else { throw Error.responseNotFound }

        let minimumValidStatusCode = 200
        let maximumValidStatusCode = 300

        let statusCodesValidRange: Range<Int> = minimumValidStatusCode..<maximumValidStatusCode

        guard statusCodesValidRange.contains(response.statusCode)
        else { throw Error.invalidStatusCode(code: response.statusCode) }
    }

    private func log(request: URLRequest) -> String {
        let url = request.url?.absoluteString ?? "No url"
        let method = request.httpMethod ?? "No method"
        let parameters: String = {
            if let httpBody = request.httpBody {
                return String(decoding: httpBody, as: UTF8.self)
            } else {
                return "No parameters"
            }
        }()

        return """
        \(#function)
        URL: \(url)
        Method: \(method)
        Parameters: \(parameters)
        """
    }

    private func log(data: Foundation.Data, response: URLResponse) -> String {
        guard let response = response as? HTTPURLResponse else { return "" }

        let statusCode = response.statusCode
        let data = String(decoding: data, as: UTF8.self)

        return """
        \(#function)
        Status code: \(statusCode)
        Data: \(data.isEmpty ? "No data" : data)
        """
    }
}
