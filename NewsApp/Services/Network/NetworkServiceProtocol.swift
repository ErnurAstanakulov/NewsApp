//
//  NetworkServiceProtocol.swift
//  NewsApp
//
//  Created by psuser on 12/21/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    func load(networkContext: NetworkContext, completion: @escaping (NetworkResponse) -> Void)
}

protocol NetworkProvider {
    var networkService: NetworkServiceProtocol { get set }
}
