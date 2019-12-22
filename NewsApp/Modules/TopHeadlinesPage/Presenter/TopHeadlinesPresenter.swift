//
//  TopHeadlinesPresenter.swift
//  NewsApp
//
//  Created by psuser on 12/22/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import UIKit

class TopHeadlinesPresenter: TopHeadlinesPresenterProtocol {
       
    var page: Int = 1
    var artObjects: [ArticleObject] = []
    var timer: Timer?
    var lastNews: News?
    var lastUpdateDate: Date?
    
    weak var view: TopHeadlinesViewProtocol?
    let router: RouterProtocol
    let services: AppServices
    
    required init(view: TopHeadlinesViewProtocol, router: RouterProtocol, services: AppServices) {
        self.view = view
        self.router = router
        self.services = services
    }
    
    func backgroundTimer() {
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(performRepeat), userInfo: nil, repeats: true)
    }
    @objc func performRepeat() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            print("Date: ", self.timer?.fireDate)
            self.page = 1
            self.loadTopHeadlines(page: 1) { [weak self] result in
                guard let presenter = self else {
                    return
                }
                switch result {
                case .success(let news):
//                    let dates = news.articles?.map({ (str) -> Date? in
//                        guard let str = str.publishedAt else { return nil }
//                        let dateFormatter = DateFormatter()
//                        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
//                        return dateFormatter.date(from: str)
//                    })
                    
                    presenter.view?.showActivityIndicator(false)
                    if presenter.lastNews != news {
                        presenter.lastNews = news
                        presenter.lastUpdateDate = presenter.timer?.fireDate
                        presenter.performShows(news)
                    }
                case .failure(let error):
                    presenter.view?.showMessage(with: error)
                }
            }
        }
    }
    
    func performShows(_ news: News) {
        var l = self
        let object = l.localSave(news)
        services.coreDataService.save(object, to: .topHeadlines)
        view?.showNews(object)
    }
    
    func loadNews() {
        view?.showActivityIndicator(true)
        if let news = services.coreDataService.getNews(for: .topHeadlines), !UIDevice.isConnectedToNetwork {
            view?.showActivityIndicator(false)
            view?.showNews(news)
        } else {
            loadTopHeadlines(page: page) { [weak self] result in
                guard var presenter = self else {
                    return
                }
                switch result {
                case .success(let news):
                    presenter.view?.showActivityIndicator(false)
//                    let object = presenter.localSave(news)
//                    presenter.services.coreDataService.save(object, to: .topHeadlines)
//                    presenter.lastNews = news
                    presenter.performShows(news)
//                    presenter.view?.showNews(object)
                case .failure(let error):
                    presenter.view?.showMessage(with: error)
                }
            }
        }
    }
    
    func showDetail(_ article: ArticleObject) {
        router.createTopHeadlinesDetail(article)
    }
    
    private func loadTopHeadlines(page: Int, completion: @escaping (Result<News>) -> Void) {
        let networkContext = TopHeadlinesNetworkContext(page: page)
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
