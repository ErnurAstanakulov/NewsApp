//
//  BaseViewProtocol.swift
//  NewsApp
//
//  Created by psuser on 12/23/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import Foundation

protocol BaseViewProtocol: class {
    var news: NewsObject? { get set }
    func showNews(_ news: NewsObject)
    func showActivityIndicator(_ isShow: Bool)
    func showMessage(with error: NetworkError)
}
