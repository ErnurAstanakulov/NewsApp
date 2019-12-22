//
//  Router.swift
//  NewsApp
//
//  Created by psuser on 12/21/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import UIKit

class Router: RouterProtocol {
    
    var navigationController: UINavigationController
    var moduleBuilder: ModuleBuilderProtocol
    
    required init(navigationController: UINavigationController, moduleBuilder: ModuleBuilderProtocol) {
        self.navigationController = navigationController
        self.moduleBuilder = moduleBuilder
    }
    
    func initialViewController() {
        navigationController.viewControllers = [moduleBuilder.createTabBar(router: self)]
    }
    
    
    func createEverythingDetail(_ article: ArticleObject) {
        let detailViewController = moduleBuilder.createEverythingDetail(router: self, with: article)
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func createTopHeadlinesDetail(_ article: ArticleObject) {
        let detailViewController = moduleBuilder.createTopHeadlinesDetail(router: self, with: article)
        navigationController.pushViewController(detailViewController, animated: true)
    }
}
