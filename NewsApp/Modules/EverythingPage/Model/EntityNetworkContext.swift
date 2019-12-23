//
//  EntityNetworkContext.swift
//  NewsApp
//
//  Created by psuser on 12/21/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import Foundation

struct EntityNetworkContext: NetworkContext {
    
    // MARK:- Properties
    private let pageSize: Int = 15
    private let page: Int
    private let theme = "bitcoin"
    var route: Route = .everyThing
    var method: NetworkMethod = .get
    var encoding: NetworkEncoding = .url
    var parameters: [String : Any] { ["pageSize": String(pageSize), "page": String(page), "q": theme, "apiKey": apiKey] }
    
    init(page: Int = 1) {
        self.page = page
    }
}
