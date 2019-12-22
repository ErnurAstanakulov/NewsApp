//
//  TopHeadlinesPresenter.swift
//  NewsApp
//
//  Created by psuser on 12/22/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import Foundation

class TopHeadlinesPresenter: TopHeadlinesPresenterProtocol {
    var page: Int = 1
    var artObjects: [ArticleObject] = []
    weak var view: TopHeadlinesViewProtocol?
    let router: RouterProtocol
    let services: AppServices
    
    required init(view: TopHeadlinesViewProtocol, router: RouterProtocol, services: AppServices) {
        self.view = view
        self.router = router
        self.services = services
    }
    
    func loadNews() {
        loadTopHeadlines { [weak self] result in
            guard var presenter = self else {
                      return
                  }
            switch result {
            case .success(let news):
                let object = presenter.localSave(news)
                presenter.services.coreDataService.save(object, to: .topHeadlines)
                presenter.view?.showNews(object)
            case .failure(let error):
                presenter.view?.showMessage(with: error)
            }
        }
    }
    
    private func loadTopHeadlines(completion: @escaping (Result<News>) -> Void) {
        let networkContext = TopHeadlinesNetworkContext()
        services.networkService.load(networkContext: networkContext) { (networkResponse) in
            DispatchQueue.main.async {
                if let news: News = networkResponse.decode() {
                    completion(.success(news))
                } else {
                    completion(.failure(networkResponse.networkError ?? NetworkError.unknown))
                }
            }
        }
    }
}
