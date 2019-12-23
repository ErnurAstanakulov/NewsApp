//
//  EverythingViewController.swift
//  NewsApp
//
//  Created by psuser on 12/21/19.
//  Copyright © 2019 psuser. All rights reserved.
//

import UIKit

class EverythingViewController: UIViewController {
    
    // MARK: - UIElement
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    var activityIndicator = UIActivityIndicatorView(style: .large)
    
    // MARK: - Properties
    var presenter: BasePresenterProtocol?
    var news: NewsObject?

    // MARK: - UI LifeCycle
    override func loadView() {
        super.loadView()
        setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.loadNews()
    }
}

extension EverythingViewController: ViewInitalizationProtocol {
    func addSubviews() {
        tableView.addSubview(refreshControl)
        tableView.addSubview(activityIndicator)
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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EverythingCell.self, forCellReuseIdentifier: String(describing: EverythingCell.self))
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(performRefresh), for: .valueChanged)
    }
}

extension EverythingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news?.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EverythingCell.self)) as! EverythingCell
        cell.textLabel?.text = String(news?.articles?[indexPath.row].descriptionNews ?? "")
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let article = news?.articles?[indexPath.row] {
            presenter?.showDetail(article)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let total = news?.totalResults, let articles = news?.articles else { return }
        if indexPath.row == articles.count - 1, total > articles.count, UIDevice.isConnectedToNetwork {
            presenter?.loadNews()
        }
    }
}

extension EverythingViewController: ActivityIndicatorProtocol {    
    func showActivityIndicator(_ isShow: Bool) {
        showActivityIndicatior(show: isShow)
    }
}

extension EverythingViewController {
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

extension EverythingViewController: EverythingViewProtocol {
    func showMessage(with error: NetworkError) {
        showAlert(error)
    }
    
    func showNews(_ news: NewsObject) {
        self.news = news
        stopRefresh()
        tableView.reloadData()
    }
}
