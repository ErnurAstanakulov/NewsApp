//
//  NewsObject.swift
//  NewsApp
//
//  Created by psuser on 12/23/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import Foundation
import CoreData

@objc(NewsObject)
public class NewsObject: NSObject, NSCoding {
    
    var status: String?
    var totalResults: Int?
    var articles: [ArticleObject]?
    public func encode(with coder: NSCoder) {
        coder.encode(status, forKey: "status")
        coder.encode(totalResults, forKey: "totalResults")
        coder.encode(articles, forKey: "articles")
    }
    
    init(status: String?, totalResults: Int?, articles: [ArticleObject]?) {
        self.status = status
        self.totalResults = totalResults
        self.articles = articles
    }
    
    public required convenience init?(coder: NSCoder) {
        let articles = coder.decodeObject(forKey: "articles") as? [ArticleObject]
        let status = coder.decodeObject(forKey: "status") as? String
        let totalResults = coder.decodeObject(forKey: "totalResults") as? Int
        self.init(status: status, totalResults: totalResults, articles: articles)
    }
}
