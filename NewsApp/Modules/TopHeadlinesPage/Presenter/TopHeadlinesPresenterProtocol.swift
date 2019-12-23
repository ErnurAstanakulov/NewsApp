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
    func performBackgroundDispatchTimer()
    var lastNews: News? { get set }
    var firstNews: News? { get set }
    var news: News? { get }
    var quene: DispatchQueue { get }
    var dispatchSourceTimer: DispatchSourceTimer! { get set }
}
