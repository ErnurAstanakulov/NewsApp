//
//  TopHeadlinesPresenter.swift
//  NewsApp
//
//  Created by psuser on 12/22/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import UIKit

class TopHeadlinesPresenter: TopHeadlinesPresenterProtocol {
    
    // MARK:- Properties
    var quene: DispatchQueue {
        return DispatchQueue(label: "concurrent", qos: .background, attributes: .concurrent) }
    var dispatchSourceTimer: DispatchSourceTimer!
    var page = 1
    var artObjects = [ArticleObject]()
    var lastNews: News?
    var firstNews: News?
    var news: News? {
        var new: News?
        quene.sync {
            new = self.lastNews
        }
        return new
    }
    
    weak var view: TopHeadlinesViewProtocol!
    let router: RouterProtocol
    let services: AppServices
    
    required init(view: TopHeadlinesViewProtocol, router: RouterProtocol, services: AppServices) {
        self.view = view
        self.router = router
        self.services = services
    }
    
    deinit {
        dispatchSourceTimer.setEventHandler(handler: {})
        dispatchSourceTimer.cancel()
        dispatchSourceTimer.resume()
    }
    
    // MARK:- Repeate request news
    func performBackgroundDispatchTimer() {
        dispatchSourceTimer = DispatchSource.makeTimerSource(queue: quene)
        dispatchSourceTimer.schedule(deadline: .now(), repeating: .seconds(5), leeway: .microseconds(300))
        dispatchSourceTimer.setEventHandler {
            print("3: THREAD", Thread.current)
            self.loadTopHeadlines(page: 1) { [weak self] result in
                print("5: THREAD", Thread.current)
                guard let presenter = self else {
                    return
                }
                switch result {
                case .success(let news):
                    if presenter.firstNews != news {
                        print("CHECK THERE 2: /(\(String(describing: presenter.firstNews?.articles?.first?.author)))")
                        presenter.quene.async(flags: .barrier) {
                            print("6: ", Thread.current)
                            presenter.lastNews = news
                        }
                    }
                case .failure(let error):
                    presenter.view?.showMessage(with: error)
                }
            }
        }
        dispatchSourceTimer.resume()
    }
    
    // MARK:- Loading news
    func loadNews() {
        view.showActivityIndicator(true)
        if let news = services.coreDataService.getNews(for: .topHeadlines), !UIDevice.isConnectedToNetwork {
            view?.showActivityIndicator(false)
            view?.showNews(news)
        } else {
            loadTopHeadlines(page: page) { [weak self] result in
                guard let presenter = self else {
                    return
                }
                presenter.view?.showActivityIndicator(false)
                switch result {
                case .success(let news):
                    print("4: ", Thread.current)
                    if presenter.page == 1 {
                        presenter.firstNews = news
                        print("CHECK HERE: /(\(String(describing: news.articles?.first?.author)))")
                    }
                    presenter.lastNews =  news
                    presenter.performShows()
                case .failure(let error):
                    presenter.view.showMessage(with: error)
                }
            }
        }
    }
    
    private func loadTopHeadlines(page: Int, completion: @escaping (Result<News>) -> Void) {
        let networkContext = TopHeadlinesNetworkContext(page: page)
        services.networkService.load(networkContext: networkContext) { (networkResponse) in
            DispatchQueue.main.async {
                guard let news: News = networkResponse.decode() else {
                    completion(.failure(networkResponse.networkError ?? NetworkError.unknown))
                    return
                }
                
                if news.status == .ok {
                    completion(.success(news))
                } else {
                    completion(.failure(NetworkError.serverError(description: news.message!)))
                }
            }
        }
    }
        
    func performShows() {
        print("2: ", Thread.current)
        guard let news = self.news else { return }
        var l = self
        let object = l.localSave(news)
        self.view.showNews(object)
        DispatchQueue.global(qos: .userInitiated).async {
            self.services.coreDataService.save(object, to: .topHeadlines)
        }
    }
    
    // MARK:- Router
    func showDetail(_ article: ArticleObject) {
        router.createTopHeadlinesDetail(article)
    }
}
