//
//  ViewInitalizationProtocol.swift
//  NewsApp
//
//  Created by psuser on 12/21/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import Foundation

protocol ViewInitalizationProtocol {
    func addSubviews()
    func setupConstraints()
    func stylizeViews()
    func extraTasks()
}

extension ViewInitalizationProtocol {
    func extraTasks() {}
    
    func setupViews() {
        addSubviews()
        setupConstraints()
        stylizeViews()
        extraTasks()
    }
}
