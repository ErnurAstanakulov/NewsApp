//
//  TopHeadlinesViewProtocol.swift
//  NewsApp
//
//  Created by psuser on 12/22/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import Foundation

protocol TopHeadlinesViewProtocol: BaseViewProtocol {
    var news: NewsObject? { get set }
}

protocol BaseViewProtocol: class {
    func showNews(_ news: NewsObject)
    func showActivityIndicator(_ isShow: Bool)
    func showMessage(with error: NetworkError)
}
