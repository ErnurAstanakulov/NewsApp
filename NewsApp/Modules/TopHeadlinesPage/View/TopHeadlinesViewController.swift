//
//  TopHeadlinesViewController.swift
//  NewsApp
//
//  Created by psuser on 12/22/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import UIKit

class TopHeadlinesViewController: UITableViewController {
    
    // MARK:- Properties
    var presenter: TopHeadlinesPresenter!
    var news: NewsObject?

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter.loadNews()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news?.articles?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EverythingCell.self)) as! EverythingCell
        let news = self.news?.articles?[indexPath.row]
        cell.textLabel?.text = news?.descriptionNews
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}

extension TopHeadlinesViewController: ViewInitalizationProtocol {
    func addSubviews() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func stylizeViews() {
        tableView.register(EverythingCell.self, forCellReuseIdentifier: String(describing: EverythingCell.self))
    }
}

extension TopHeadlinesViewController: TopHeadlinesViewProtocol {
    func showNews(_ news: NewsObject) {
        self.news = news
        tableView.reloadData()
    }
    
    func showActivityIndicator(_ isShow: Bool) {
        
    }
    
    func showMessage(with error: NetworkError) {
        
    }
}
