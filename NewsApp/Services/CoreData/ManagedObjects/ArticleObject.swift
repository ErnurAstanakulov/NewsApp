//
//  ArticleObject.swift
//  NewsApp
//
//  Created by psuser on 12/23/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import Foundation
import CoreData

@objc(ArticleObject)
public class ArticleObject: NSObject, NSCoding {
    var source: SourceObject?
    var author: String?
    var title: String?
    var descriptionNews: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
    
    init(source: SourceObject?, author: String?, title: String?, descriptionNews: String?, url: String?, urlToImage: String?, publishedAt: String?, content: String?) {
        self.source = source
        self.author = author
        self.title = title
        self.descriptionNews = descriptionNews
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(source, forKey: "source")
        coder.encode(author, forKey: "author")
        coder.encode(title, forKey: "title")
        coder.encode(descriptionNews, forKey: "descriptionNews")
        coder.encode(url, forKey: "url")
        coder.encode(urlToImage, forKey: "urlToImage")
        coder.encode(publishedAt, forKey: "publishedAt")
        coder.encode(content, forKey: "content")
    }
    
    public required convenience init?(coder: NSCoder) {
        let source = coder.decodeObject(forKey: "source") as? SourceObject
        let author = coder.decodeObject(forKey: "author") as? String
        let title = coder.decodeObject(forKey: "title") as? String
        let descriptionNews = coder.decodeObject(forKey: "descriptionNews") as? String
        let url = coder.decodeObject(forKey: "url") as? String
        let urlToImage = coder.decodeObject(forKey: "urlToImage") as? String
        let publishedAt = coder.decodeObject(forKey: "publishedAt") as? String
        let content = coder.decodeObject(forKey: "content") as? String
        self.init(source: source, author: author, title: title, descriptionNews: descriptionNews, url: url, urlToImage: urlToImage, publishedAt: publishedAt, content: content)
    }
}
