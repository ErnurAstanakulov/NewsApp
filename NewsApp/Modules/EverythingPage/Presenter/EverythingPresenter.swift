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
    
    func loadNews() {
        view.showActivityIndicator(true)
        if let news = appServices.coreDataService.getNews(for: .everything), !UIDevice.isConnectedToNetwork {
            view.showActivityIndicator(false)
            view.showNews(news)
        } else {
            let networkContext = EntityNetworkContext(page: page)
            appServices.networkService.load(networkContext: networkContext, completion: { [weak self] networkResponse in
                guard var self = self else { return }
                DispatchQueue.main.async {
                    if let news: News = networkResponse.decode() {
                        self.view.showActivityIndicator(false)
                        let object = self.localSave(news)
                        self.appServices.coreDataService.save(object, to: .everything)
                        self.view.showNews(object)
                    } else {
                        self.view.showMessage(with: networkResponse.networkError ?? NetworkError.unknown)
                    }
                }
            })
        }
    }
    
    func showDetail(_ article: ArticleObject) {
        router.createEverythingDetail(article)
    }
}
