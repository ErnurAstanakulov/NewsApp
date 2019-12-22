//
//  ModuleBuilder.swift
//  NewsApp
//
//  Created by psuser on 12/21/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import UIKit

class ModuleBuilder: ModuleBuilderProtocol {
    let appServices = AppServices()

    func createTabBar(router: RouterProtocol) -> UIViewController {
        let view = TabBarController()
        let presenter = TabBarPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createTopHeadlines(router: RouterProtocol) -> UIViewController {
        let view = TopHeadlinesViewController()
        let presenter = TopHeadlinesPresenter(view: view, router: router, services: appServices)
        view.presenter = presenter
        return view
    }
    
    func createEverything(router: RouterProtocol) -> UIViewController {
        let view = EverythingViewController()
        let presenter = EverythingPresenter(view: view, appServices: appServices, router: router)
        view.presenter = presenter
        return view
    }
}
