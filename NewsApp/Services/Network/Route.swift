//
//  Route.swift
//  NewsApp
//
//  Created by psuser on 12/21/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import Foundation

enum Route: RouteProtocol {
    case everyThing
    case topHeadlines
    
    var serverUrl: String {
        return "https://newsapi.org/v2/"
    }
    
}

extension Route {
    var rawValue: String {
        switch self {
        case .everyThing:
            return "everything"
        case .topHeadlines:
            return "top-headlines?country=us&"
        }
    }
}
