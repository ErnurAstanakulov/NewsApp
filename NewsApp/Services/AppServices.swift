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
    var coreDataService: CoreDataServiceProtocol = CoreDataStackService()
    var networkService: NetworkServiceProtocol = NetworkService()
}

