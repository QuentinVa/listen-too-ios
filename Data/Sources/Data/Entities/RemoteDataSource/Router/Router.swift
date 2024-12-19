//
//  Router.swift
//  
//
//  Created by Quentin Varlet on 28/02/2023.
//

import Foundation

protocol RouterProtocol {
    func urlRequest(httpMethod: HTTPMethod, request: Request) throws -> URLRequest
}

// swiftlint:disable:file lower_acl_than_parent type_contents_order
// swiftlint:disable:file file_types_order prefer_self_in_static_references

class Router: RouterProtocol {

    // MARK: Properties

    public var header: [String: String] = ["content-type": "application/json"]
    public var timeoutInterval: TimeInterval = 60
    public var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalCacheData

    // MARK: RouterProtocol

    func urlRequest(httpMethod: HTTPMethod, request: Request) throws -> URLRequest {
        let urlRequest = NSMutableURLRequest()
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.timeoutInterval = timeoutInterval
        urlRequest.cachePolicy = cachePolicy

        header.forEach { urlRequest.setValue($0.1, forHTTPHeaderField: $0.0) }

        if httpMethod == .get {
            urlRequest.url = URL(string: Router.appendGetParameter(url: request.url, parameter: URLEncoder.encode(request.params())))
        } else {
            urlRequest.url = URL(string: request.url)
            urlRequest.httpBody = URLEncoder.encode(request.params()).data(using: String.Encoding.utf8, allowLossyConversion: false)
        }
        return urlRequest as URLRequest
    }

    // MARK: Internal methods

    internal static func check(response: URLResponse?) -> NSError? {
        let minResponse: Int = 200
        let maxResponse: Int = 300

        guard let notNilResponse = response else {
            return createError(.recieveNilResponse, [:])
        }

        // swiftlint:disable:next force_cast
        let httpResponse = notNilResponse as! HTTPURLResponse
        guard (minResponse..<maxResponse) ~= httpResponse.statusCode else {
            return createError(.recieveErrorHttpStatus, ["statusCode": httpResponse.statusCode])
        }
        return nil
    }

    internal static func appendGetParameter(url: String, parameter: String) -> String {
        let separator: String
        if url.contains("?") {
            if ["?", "&"].contains(url.suffix(1)) {
                separator = ""
            } else {
                separator = "&"
            }
        } else {
            separator = "?"
        }
        return [url, parameter].joined(separator: separator)
    }

    static func createError(_ code: APIError, _ info: [String: Any]) -> NSError {
        NSError(domain: "ApiError", code: code.rawValue, userInfo: info)
    }
}

// swiftlint:disable:next convenience_type
public class URLEncoder {
    public class func encode(_ parameters: [(key: String, value: String)]) -> String {
        let encodedString: String = parameters.compactMap { params in
            guard let value = params.value.addingPercentEncoding(withAllowedCharacters: .alphanumerics) else {
                return nil
            }
            return "\(params.key)=\(value)"
        }
            .joined(separator: "&")
        return encodedString
    }
}
