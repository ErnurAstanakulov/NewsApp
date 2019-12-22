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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
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
    }
}

extension TabBarController: TabBarViewProtocol {
    func setPages(_ viewControllers: [UIViewController]) {
        let navViewControllers = viewControllers.map { UINavigationController(rootViewController: $0) }
        pagesTabBarController.setViewControllers(navViewControllers, animated: true)
    }
}
