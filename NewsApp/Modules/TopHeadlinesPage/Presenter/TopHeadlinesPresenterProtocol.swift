//
//  TopHeadlinesPresenterProtocol.swift
//  NewsApp
//
//  Created by psuser on 12/22/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import Foundation

protocol TopHeadlinesPresenterProtocol: BasePresenterProtocol {
    init(view: TopHeadlinesViewProtocol, router: RouterProtocol, services: AppServices)
}
