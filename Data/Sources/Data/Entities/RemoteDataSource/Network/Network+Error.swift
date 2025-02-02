//
//  Network+Error.swift
//  
//
//  Created by Quentin Varlet on 28/02/2023.
//

extension Network {

    enum Error: Swift.Error {

        case responseNotFound
        case invalidStatusCode(code: Int)
    }
}
