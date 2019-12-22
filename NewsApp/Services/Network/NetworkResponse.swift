//
//  NetworkResponse.swift
//  NewsApp
//
//  Created by psuser on 12/21/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import Foundation

protocol NetworkResponse {
    var data: Data? { get }
    var networkError: NetworkError? { get }
}

extension NetworkResponse {
    
    func decode<T: Decodable>() -> T? {
        guard let data = data else {
            return nil
        }
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            dump(error)
            return nil
        }
    }
}
