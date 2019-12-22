//
//  Everything.swift
//  NewsApp
//
//  Created by psuser on 12/21/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import Foundation

struct News: Decodable, Equatable {
    let status: String?
    let totalResults: Int?
    var articles: [Article]?
}

struct Article: Decodable, Equatable {
    var source: Source?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}

struct Source: Decodable, Equatable {
    var id: String?
    var name: String?
}
