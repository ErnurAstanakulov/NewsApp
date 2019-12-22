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
    
    func createTopHeadlines() {
        
    }
    
    func createEverythins() {
        
    }
    
}
