//
//  TabBarPresenterProtocol.swift
//  NewsApp
//
//  Created by psuser on 12/21/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import Foundation

protocol TabBarPresenterProtocol {
    init(view: TabBarViewProtocol, router: RouterProtocol)
    func setPages()
}
