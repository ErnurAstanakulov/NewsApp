//
//  ModuleBuilder.swift
//  NewsApp
//
//  Created by psuser on 12/21/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import UIKit

class ModuleBuilder: ModuleBuilderProtocol {
    
    // MARK:- Properties
    let appServices = AppServices()
    weak var mainRouter: RouterProtocol!

    func createTabBar(router: RouterProtocol) -> UIViewController {
        let view = TabBarController()
        let presenter = TabBarPresenter(view: view, router: router)
        view.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        view.presenter = presenter
        mainRouter = router
        return view
    }
    
    func createTopHeadlines() -> UIViewController {
        let view = TopHeadlinesViewController()
        view.navigationItem.title = "Топ"
        let presenter = TopHeadlinesPresenter(view: view, router: mainRouter, services: appServices)
        view.presenter = presenter
        return view
    }
    
    func createEverything() -> UIViewController {
        let view = EverythingViewController()
        view.navigationItem.title = "Разное"
        let presenter = EverythingPresenter(view: view, appServices: appServices, router: mainRouter)
        view.presenter = presenter
        return view
    }
    
    func createEverythingDetail(router: RouterProtocol, with article: ArticleObject) -> UIViewController {
          let view = BaseDetailViewController()
          let presenter = BaseDetailPresenter(view: view, model: article)
          view.title = article.author
          view.presenter = presenter
          return view
      }
      
      func createTopHeadlinesDetail(router: RouterProtocol, with article: ArticleObject) -> UIViewController {
          let view = BaseDetailViewController()
          let presenter = BaseDetailPresenter(view: view, model: article)
          view.title = article.author
          view.presenter = presenter
          return view
      } 
}
