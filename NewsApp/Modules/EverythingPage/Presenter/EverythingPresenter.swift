//
//  EverythingPresenter.swift
//  NewsApp
//
//  Created by psuser on 12/21/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import UIKit

class EverythingPresenter: EverythingPresenterProtocol {
    
    // MARK:- Properties
    weak var view: EverythingViewProtocol!
    let appServices: AppServicesProtocol
    let router: RouterProtocol
    var page = 1
    var artObjects = [ArticleObject]()
    
    required init(view: EverythingViewProtocol, appServices: AppServicesProtocol, router: RouterProtocol) {
        self.view = view
        self.appServices = appServices
        self.router = router
    }
    
    // MARK:- Load everyting news
    
    func loadNews() {
        view.showActivityIndicator(true)
        if let news = appServices.coreDataService.getNews(for: .everything), !UIDevice.isConnectedToNetwork {
            view.showActivityIndicator(false)
            view.showNews(news)
        } else {
            let networkContext = EverythingNetworkContext(page: page)
            appServices.networkService.load(networkContext: networkContext, completion: { [weak self] networkResponse in
                guard var self = self else { return }
                DispatchQueue.main.async {
                    self.view.showActivityIndicator(false)
                    if let news: News = networkResponse.decode() {
                        if news.status == Status.ok {
                            print("1: ", Thread.current)
                            let object = self.localSave(news)
                            self.appServices.coreDataService.save(object, to: .everything)
                            self.view.showNews(object)
                        } else {
                            self.view.showMessage(with: NetworkError.serverError(description: news.message!))
                        }
                    } else {
                        self.view.showMessage(with: networkResponse.networkError ?? NetworkError.unknown)
                    }
                }
            })
        }
    }
    
    // MARK:- Routering
    func showDetail(_ article: ArticleObject) {
        router.createEverythingDetail(article)
    }
}
