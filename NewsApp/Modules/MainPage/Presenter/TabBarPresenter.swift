//
//  TabBarPresenter.swift
//  NewsApp
//
//  Created by psuser on 12/21/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import UIKit

class TabBarPresenter: TabBarPresenterProtocol {
    weak var view: TabBarViewProtocol?
    let router: RouterProtocol
    
    required init(view: TabBarViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func setPages() {
        let topHeadlineViewController = router.moduleBuilder.createTopHeadlines()
        let topHeadlineTabItem = TabItem(icon: NewsAppImage.topHeadline.uiImage, title: "TOP")
        topHeadlineViewController.tabBarItem.title = topHeadlineTabItem.title
        topHeadlineViewController.tabBarItem.image = topHeadlineTabItem.icon
        let everythingViewController = router.moduleBuilder.createEverything()
        let everythingTabItem = TabItem(icon: NewsAppImage.everything.uiImage, title: "EVERYTHING")
        everythingViewController.tabBarItem.title = everythingTabItem.title
        everythingViewController.tabBarItem.image = everythingTabItem.icon
        view?.setPages([topHeadlineViewController, everythingViewController])
    }
}
