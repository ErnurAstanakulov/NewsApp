//
//  EverythingPresenterProtocol.swift
//  NewsApp
//
//  Created by psuser on 12/21/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import Foundation

protocol EverythingPresenterProtocol: BasePresenterProtocol {
    init(view: EverythingViewProtocol, appServices: AppServicesProtocol, router: RouterProtocol)
}
