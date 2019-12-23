//
//  TopHeadlinesViewController.swift
//  NewsApp
//
//  Created by psuser on 12/22/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import UIKit

class TopHeadlinesViewController: UIViewController {
    
    // MARK: - UIElements
    private let tableView = UITableView()
    private let refreshTableControl = UIRefreshControl()
    var activityIndicator = UIActivityIndicatorView(style: .large)

    // MARK:- Properties
    var presenter: TopHeadlinesPresenterProtocol?
    var news: NewsObject?

    // MARK: - View Lifecycle
    override func loadView() {
        super.loadView()
        setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadNews()
        if UIDevice.isConnectedToNetwork { presenter?.performBackgroundDispatchTimer() }
    }
}

extension TopHeadlinesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news?.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EverythingCell.self)) as! EverythingCell
        let article = self.news?.articles?[indexPath.row]
        cell.textLabel?.text = article?.descriptionNews
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let article = news?.articles?[indexPath.row] else { return }
        presenter?.showDetail(article)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let total = news?.totalResults, let articles = news?.articles else { return }
        if indexPath.row == articles.count - 1, total > articles.count, UIDevice.isConnectedToNetwork {
            presenter?.loadNews()
        }
    }
}

extension TopHeadlinesViewController {
    @objc func performRefresh() {
        presenter?.didRefresh()
    }
    
    private func stopRefresh() {
        if let refreshControl = tableView.refreshControl,
            refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }
}

extension TopHeadlinesViewController: ViewInitalizationProtocol {
    func addSubviews() {
        tableView.addSubview(activityIndicator)
        tableView.addSubview(refreshTableControl)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.addConstaintsToFill()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        var layouts: [NSLayoutConstraint] = []
        layouts += [
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: 60),
            activityIndicator.heightAnchor.constraint(equalToConstant: 60)
        ]

        NSLayoutConstraint.activate(layouts)
    }
    
    func stylizeViews() {
        view.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        activityIndicator.hidesWhenStopped = true
    }
    
    func extraTasks() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(EverythingCell.self, forCellReuseIdentifier: String(describing: EverythingCell.self))
        tableView.refreshControl = refreshTableControl
        refreshTableControl.addTarget(self, action: #selector(performRefresh), for: .valueChanged)
    }
}

extension TopHeadlinesViewController: ActivityIndicatorProtocol {
    func showActivityIndicator(_ isShow: Bool) {
        showActivityIndicatior(show: isShow)
    }
}

extension TopHeadlinesViewController: TopHeadlinesViewProtocol {
    func showNews(_ news: NewsObject) {
        self.news = news
        stopRefresh()
        tableView.reloadData()
    }
        
    func showMessage(with error: NetworkError) {
        showAlert(error)
    }
}
