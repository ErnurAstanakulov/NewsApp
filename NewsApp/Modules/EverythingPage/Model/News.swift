//
//  Everything.swift
//  NewsApp
//
//  Created by psuser on 12/21/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import Foundation

struct News: Codable, Equatable {
    let status: Status?
    let totalResults: Int?
    var articles: [Article]?
    var code: String?
    var message: String?
}
