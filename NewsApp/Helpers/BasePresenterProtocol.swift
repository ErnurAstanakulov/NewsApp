//
//  BasePresenterProtocol.swift
//  NewsApp
//
//  Created by psuser on 12/23/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import Foundation

protocol BasePresenterProtocol {
    func loadNews()
    var page: Int { get set }
    var artObjects: [ArticleObject] { get set }
    func showDetail(_ article: ArticleObject)
}

extension BasePresenterProtocol {
    
    mutating func localSave(_ news: News) -> NewsObject {
        for article in news.articles ?? [] {
            let src = SourceObject(id: article.source?.id, name: article.source?.name)
            let art = ArticleObject(source: src, author: article.author, title: article.title, descriptionNews: article.description, url: article.url, urlToImage: article.urlToImage, publishedAt: article.publishedAt, content: article.content)
            artObjects.append(art)
        }
        page += 1
        return NewsObject(status: news.status.map { $0.rawValue }, totalResults: news.totalResults, articles: artObjects)
    }
    
    mutating func didRefresh() {
        page = 1
        loadNews()
    }
}
