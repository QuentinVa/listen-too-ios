//
//  RemoteDataSource.swift
//  
//
//  Created by Quentin Varlet on 01/03/2023.
//

protocol RemoteDataSourceProtocol: AnyObject {

    var network: NetworkProtocol { get }
}

class RemoteDataSource: RemoteDataSourceProtocol {

    // MARK: RemoteDataSourceProtocol

    let network: NetworkProtocol

    // MARK: Init

    init(network: NetworkProtocol = Network()) {
        self.network = network
    }
}
