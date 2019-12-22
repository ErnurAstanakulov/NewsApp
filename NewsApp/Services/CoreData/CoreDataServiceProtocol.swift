//
//  CoreDataServiceProtocol.swift
//  NewsApp
//
//  Created by psuser on 12/23/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import Foundation

protocol CoreDataServiceProtocol {
    func getNews(for entity: DataEntity) -> NewsObject?
    func save(_ news: NewsObject, to entity: DataEntity)
}

protocol CoreDataProvider {
    var coreDataService: CoreDataServiceProtocol { get }
}
