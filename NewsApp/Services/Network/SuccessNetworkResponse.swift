//
//  SuccessNetworkResponse.swift
//  NewsApp
//
//  Created by psuser on 12/21/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import Foundation

class SuccessNetworkResponse: NetworkResponse {
    var data: Data?
    var networkError: NetworkError? { return nil }
    
    init(data: Data?) {
        self.data = data
    }
}
