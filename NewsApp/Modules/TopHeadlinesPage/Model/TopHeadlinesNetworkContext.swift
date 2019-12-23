//
//  TopHeadlinesNetworkContext.swift
//  NewsApp
//
//  Created by psuser on 12/22/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import Foundation

struct TopHeadlinesNetworkContext: NetworkContext {
    private let pageSize: Int = 15
    private let page: Int
    private let theme = "bbc-news"
    init(page: Int = 1) {
        self.page = page
    }
    var route: Route = .topHeadlines
    var method: NetworkMethod = .get
    var encoding: NetworkEncoding = .url
    var parameters: [String : Any] { ["pageSize": String(pageSize), "page": String(page), "sources": theme, "apiKey": apiKey] }
}
