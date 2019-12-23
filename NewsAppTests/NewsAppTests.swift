//
//  NewsAppTests.swift
//  NewsAppTests
//
//  Created by psuser on 12/21/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import XCTest
@testable import NewsApp
class MockEverythingView: BaseViewProtocol {
    var news: NewsObject? 

    func showNews(_ news: NewsObject) {
        
    }
    
    func showActivityIndicator(_ isShow: Bool) {
        
    }
    
    func showMessage(with error: NetworkError) {
        
    }
}

class MockCoreDataService: CoreDataServiceProtocol {
    func getNews(for entity: DataEntity) -> NewsObject? {
        return nil
    }
    
    func save(_ news: NewsObject, to entity: DataEntity) {}
}

class MockNetworkService: NetworkServiceProtocol {
    var response: NetworkResponse!
    
    init() {}
    
    convenience init(response: NetworkResponse) {
        self.init()
        self.response = response
    }
    
    func load(networkContext: NetworkContext, completion: @escaping (NetworkResponse) -> Void) {
        if let response = response {
            completion(response)
        } else {
            completion(FailureNetworkResponse(networkError: .serverError(description: "test request finished with error")))
        }
    }
}


class MockAppService: AppServicesProtocol {
    var coreDataService: CoreDataServiceProtocol
    
    var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol, coreDataService: CoreDataServiceProtocol) {
        self.networkService = networkService
        self.coreDataService = coreDataService
    }
    
}

class NewsAppTests: XCTestCase {

    var view: MockEverythingView!
    var presenter: EverythingPresenter!
    var appService: AppServicesProtocol!
    var networkService: NetworkServiceProtocol!
    var coreDataService: CoreDataServiceProtocol!
    var router: RouterProtocol!
    var news: News?
    
    override func setUp() {
        router = Router(navigationController: UINavigationController(), moduleBuilder: ModuleBuilder())
    }

    override func tearDown() {
        view = nil
        presenter = nil
        appService = nil
        networkService = nil
        coreDataService = nil
    }

    func testExample() {
    
        let source = Source(id: nil, name: nil)
        let articles = [
            Article(source: source, author: "Bar", title: "Baz", description: "Bar", url: "Bar", urlToImage: "Bar", publishedAt: "Bar", content: "Bar")
        ]
        news = News(status: .ok, totalResults: 112, articles: articles)
        let data = try! JSONEncoder().encode(news)
        let networkResponse = SuccessNetworkResponse(data: data)
        
        networkService = MockNetworkService(response: networkResponse)
        coreDataService = MockCoreDataService()
        appService = MockAppService(networkService: networkService, coreDataService: coreDataService)
        
        var catchNews: News?
        let context = EverythingNetworkContext()
        networkService.load(networkContext: context) { (networkResponse) in
            if let news: News = networkResponse.decode() {
                catchNews = news
            }
        }
        
        XCTAssertEqual(catchNews, news)
    }
}
