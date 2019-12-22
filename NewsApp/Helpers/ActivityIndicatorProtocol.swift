//
//  ActivityIndicatorProtocol.swift
//  NewsApp
//
//  Created by psuser on 12/22/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import UIKit

protocol ActivityIndicatorProtocol where Self: UIViewController {
    var activityIndicator: UIActivityIndicatorView { get set }
    func showActivityIndicatior(show: Bool)
}

extension ActivityIndicatorProtocol {
    
    func showActivityIndicatior(show: Bool) {
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
}
