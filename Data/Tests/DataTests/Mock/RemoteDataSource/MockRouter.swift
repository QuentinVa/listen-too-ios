//
//  MockRouter.swift
//  
//
//  Created by Quentin Varlet on 09/03/2023.
//

@testable import Data
import Foundation

// swiftlint:disable:file force_unwrapping lower_acl_than_parent type_contents_order

final class MockRouter: RouterProtocol {

    // MARK: Properties

    public var header: [String: String] = ["content-type": "application/json"]
    public var timeoutInterval: TimeInterval = 60
    public var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalCacheData
    static let apiTaskSession = URLSession(configuration: URLSessionConfiguration.ephemeral)

    var dataForRequestCalled = false
    var dataForRequestParams: Request?

    // MARK: RouterProtocol

    func urlRequest(httpMethod: HTTPMethod, request: Request) throws -> URLRequest {
        dataForRequestCalled = true
        dataForRequestParams = request

        let urlRequest = NSMutableURLRequest()
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.timeoutInterval = timeoutInterval
        urlRequest.cachePolicy = cachePolicy

        header.forEach { urlRequest.setValue($0.1, forHTTPHeaderField: $0.0) }

        return URLRequest(url: URL(string: Router.appendGetParameter(url: request.url, parameter: URLEncoder.encode(request.params())))!)
    }
}
