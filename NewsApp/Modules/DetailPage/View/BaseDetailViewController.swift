//
//  BaseDetailViewController.swift
//  NewsApp
//
//  Created by psuser on 12/22/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import UIKit

class BaseDetailViewController: UIViewController {
    
    // MARK:- UIElements
    private lazy var textView = UITextView()
    
    // MARK: - Properties
    private var text: String? {
        didSet {
            textView.text = self.text
        }
    }
    var presenter: BaseDetailPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter.getNewsDescription()
        let rightBarItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(performAdd))
        navigationItem.rightBarButtonItem = rightBarItem
    }
    
    @objc func performAdd() {
        showAlert(NetworkError.serverError(description: "Еще не реализовано!"))
    }
}

extension BaseDetailViewController: ViewInitalizationProtocol {
    func addSubviews() {
        view.addSubview(textView)
    }
    
    func setupConstraints() {
        textView.addConstaintsToFill()
    }
    
    func stylizeViews() {
        textView.isUserInteractionEnabled = false
    }
}

extension BaseDetailViewController: BaseDetailViewProtocol {
    func showDetailNews(with text: String) {
        self.text = text
    }
}
