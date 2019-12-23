//
//  Result.swift
//  NewsApp
//
//  Created by psuser on 12/23/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import Foundation

enum Result<T>{
    case success(T)
    case failure(NetworkError)
}
