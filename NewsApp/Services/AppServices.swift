//
//  AppServices.swift
//  NewsApp
//
//  Created by psuser on 12/21/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import Foundation

protocol AppServicesProtocol: class, CoreDataProvider, NetworkProvider { }

class AppServices: AppServicesProtocol {
    // MARK:- Services
    var coreDataService: CoreDataServiceProtocol { return CoreDataStackService() }
    var networkService: NetworkServiceProtocol { return NetworkService() }
}

protocol CoreDataProvider {
    var coreDataService: CoreDataServiceProtocol { get }
}

protocol NetworkProvider {
    var networkService: NetworkServiceProtocol { get }
}

protocol CoreDataServiceProtocol {
    func getNews(for entity: DataEntity) -> NewsObject?
    func save(_ news: NewsObject, to entity: DataEntity)
}
