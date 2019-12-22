//
//  ModuleBuilderProtocol.swift
//  NewsApp
//
//  Created by psuser on 12/21/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import UIKit

protocol ModuleBuilderProtocol {
    func createTopHeadlines() -> UIViewController
    func createEverything() -> UIViewController
    func createTabBar(router: RouterProtocol) -> UIViewController
    func createEverythingDetail(router: RouterProtocol, with article: ArticleObject) -> UIViewController
    func createTopHeadlinesDetail(router: RouterProtocol, with article: ArticleObject) -> UIViewController
}
