//
//  TabBarController.swift
//  NewsApp
//
//  Created by psuser on 12/21/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import UIKit

class TabBarController: UIViewController {
    var presenter: TabBarPresenterProtocol?
    var pagesTabBarController = UITabBarController()
    
    override func loadView() {
        super.loadView()
        setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.setPages()
    }
}

extension TabBarController: ViewInitalizationProtocol {
    func addSubviews() {
        addChild(pagesTabBarController)
        view.addSubview(pagesTabBarController.view)
    }

    func setupConstraints() {
        pagesTabBarController.view.addConstaintsToFill()
    }
    
    func stylizeViews() {
        view.backgroundColor = .white
    }
    
    private func stylizePage(_ viewController: UIViewController, title: String?, icon: UIImage?) {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = icon
        
        viewController.navigationController?.navigationBar.isHidden = true

    }
}

extension TabBarController: TabBarViewProtocol {
    func setPages(_ viewControllers: [UIViewController]) {
        print("TAB BAR")
        pagesTabBarController.setViewControllers(viewControllers, animated: true)
    }
}
