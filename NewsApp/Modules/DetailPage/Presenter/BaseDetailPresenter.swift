//
//  BaseDetailPresenter.swift
//  NewsApp
//
//  Created by psuser on 12/22/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import Foundation

class BaseDetailPresenter: BaseDetailPresenterProtocol {
    
    // MARK:- Properties
    private weak var view: BaseDetailViewProtocol!
    private let model: ArticleObject!
    
    init(view: BaseDetailViewProtocol, model: ArticleObject) {
        self.view = view
        self.model = model
    }
    
    func getNewsDescription() {
        view.showDetailNews(with: model.descriptionNews ?? "")
    }
}
