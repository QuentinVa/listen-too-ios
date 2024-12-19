//
//  APIError.swift
//  
//
//  Created by Quentin Varlet on 28/02/2023.
//

import Foundation

public enum APIError: Int, Error {

    case recieveNilResponse = 0,
    recieveErrorHttpStatus,
    recieveNilBody,
    failedParse
}
