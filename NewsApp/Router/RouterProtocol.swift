//
//  RouterProtocol.swift
//  NewsApp
//
//  Created by psuser on 12/21/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import UIKit

protocol ModuleRouterProtocol {
    var navigationController: UINavigationController { get set }
    var moduleBuilder: ModuleBuilderProtocol { get set }
}

protocol RouterProtocol: ModuleRouterProtocol {
    init(navigationController: UINavigationController, moduleBuilder: ModuleBuilderProtocol)
    func initialViewController()
    func createTopHeadlines()
    func createEverythins()
}
