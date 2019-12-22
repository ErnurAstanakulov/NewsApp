//
//  ModuleBuilderProtocol.swift
//  NewsApp
//
//  Created by psuser on 12/21/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import UIKit

protocol ModuleBuilderProtocol {
    func createTopHeadlines(router: RouterProtocol) -> UIViewController
    func createEverything(router: RouterProtocol) -> UIViewController
    func createTabBar(router: RouterProtocol) -> UIViewController
}
