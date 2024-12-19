//
//  MockNetwork.swift
//  
//
//  Created by Quentin Varlet on 09/03/2023.
//

@testable import Data
import Foundation

// swiftlint:disable:file force_unwrapping force_try
final class MockNetwork: NetworkProtocol {

    // MARK: Properties

    private var data: Foundation.Data
    var loadCalled = false
    var loadDecodableCalled = false
    var ensureResponseIsValid = false

    var request: URLRequest?
    var response: URLResponse?

    var jsonResourceName: String? {
        didSet {
            let url = Bundle.module.url(forResource: jsonResourceName, withExtension: "json")!
            data = try! Data(contentsOf: url)
        }
    }

    // MARK: NetworkProtocol

    var decoder: JSONDecoder

    // MARK: Init

    init() {
        self.decoder = JSONDecoder()
        self.data = Data()
    }

    // MARK: NetworkProtocol

    func load(request: URLRequest) async throws -> Data {
        loadCalled = true
        self.request = request

        let (data, response) = try await URLSession.shared.data(for: request)
        try ensureResponseIsValid(response: response)

        return data
    }

    func load<T>(request: URLRequest) async throws -> T where T: Decodable {
        loadDecodableCalled = true
        self.request = request

        let data = try await load(request: request)
        return try decoder.decode(T.self, from: data)
    }

    private func ensureResponseIsValid(response: URLResponse) throws {
        ensureResponseIsValid = true
        self.response = response

        guard let response = response as? HTTPURLResponse
        else { throw Network.Error.responseNotFound }

        let minimumValidStatusCode = 200
        let maximumValidStatusCode = 300

        let statusCodesValidRange: Range<Int> = minimumValidStatusCode..<maximumValidStatusCode

        guard statusCodesValidRange.contains(response.statusCode)
        else { throw Network.Error.invalidStatusCode(code: response.statusCode) }
    }
}
