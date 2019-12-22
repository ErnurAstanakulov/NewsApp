//
//  NetworkMethod.swift
//  NewsApp
//
//  Created by psuser on 12/21/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import Foundation

public enum NetworkMethod: String, CustomStringConvertible {
    case get, post, put, delete
    public var description: String {
        return self.rawValue.uppercased()
    }
}
