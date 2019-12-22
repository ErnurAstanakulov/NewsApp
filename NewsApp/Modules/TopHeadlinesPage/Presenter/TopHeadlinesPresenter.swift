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
    private let quene = DispatchQueue(label: "concurrent", attributes: .concurrent)
    var lastNews: News?
    var firstNews: News?
    var news: News? {
        var new: News?
        quene.sync {
            new = self.lastNews
        }
        return new
    }
    
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
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            print("1: ", Thread.current)
            self.loadTopHeadlines(page: 1) { [weak self] result in
                guard let presenter = self else {
                    return
                }
                switch result {
                case .success(let news):
                    presenter.view?.showActivityIndicator(false)
                    if presenter.firstNews != news {
                        print("CHECK THERE: /(\(news.articles?.first?.author))")
                        print("CHECK THERE 2: /(\(presenter.firstNews?.articles?.first?.author))")
                        presenter.quene.async(flags: .barrier) {
                            print("5: ", Thread.current)
                            presenter.lastNews = news
                        }
                        presenter.performShows()
                    }
                case .failure(let error):
                    presenter.view?.showMessage(with: error)
                }
            }
        }
    }
    
    func performShows() {
        print("2: ", Thread.current)
        DispatchQueue.main.async {
            guard let news = self.news else { return }
                  var l = self
                  let object = l.localSave(news)
                  self.services.coreDataService.save(object, to: .topHeadlines)
            self.view?.showNews(object)
        }
      
    }
    
    func loadNews() {
        view?.showActivityIndicator(true)
        if let news = services.coreDataService.getNews(for: .topHeadlines), !UIDevice.isConnectedToNetwork {
            view?.showActivityIndicator(false)
            view?.showNews(news)
        } else {
            loadTopHeadlines(page: page) { [weak self] result in
                guard let presenter = self else {
                    return
                }
                switch result {
                case .success(let news):
                    presenter.view?.showActivityIndicator(false)
                    print("4: ", Thread.current)
                    if presenter.page == 1 {
                        presenter.firstNews = news
                        print("CHECK HERE: /(\(news.articles?.first?.author))")
                    }
                    presenter.quene.async(flags: .barrier) {
                        print("3: ", Thread.current)
                        presenter.lastNews =  news
                    }
                    presenter.page += 1
                    presenter.performShows()
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
