//
//  FailureNetworkResponse.swift
//  NewsApp
//
//  Created by psuser on 12/21/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import Foundation

class FailureNetworkResponse: NetworkResponse {
    var data: Data? { return nil }
    var networkError: NetworkError?
    
    init(networkError: NetworkError) {
        self.networkError = networkError
    }
}
