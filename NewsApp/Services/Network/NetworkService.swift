//
//  NetworkService.swift
//  NewsApp
//
//  Created by psuser on 12/21/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import Foundation

class NetworkService: NetworkServiceProtocol {
    func load(networkContext: NetworkContext, completion: @escaping (NetworkResponse) -> Void) {
        guard let request = urlRequestFrom(networkContext: networkContext) else {
            completion(FailureNetworkResponse(networkError: .noConnection))
            return
        }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard response != nil else {
                completion(FailureNetworkResponse(networkError: .dataLoad))
                return
            }
            completion(SuccessNetworkResponse(data: data))
        }.resume()
    }
    
    private func urlRequestFrom(networkContext context: NetworkContext) -> URLRequest? {
        var urlComponents = URLComponents(string: context.urlString)
        var queryItems = [URLQueryItem]()
        for (key, value) in context.parameters {
            queryItems.append(URLQueryItem(name: key, value: value as? String))
        }
        urlComponents?.queryItems = queryItems
        guard let url = urlComponents?.url else { return nil }
        print("URL \(url)")
        var request = URLRequest(url: url)
        request.httpMethod = context.method.description
        request.httpBody = context.httpBody
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        context.header.forEach {
            request.setValue($1, forHTTPHeaderField: $0)
        }
        return request
    }
}
