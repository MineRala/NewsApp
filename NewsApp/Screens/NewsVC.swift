//
//  NewsVC.swift
//  NewsApp
//
//  Created by Mine Rala on 20.10.2021.
//

import UIKit

class NewsVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    private lazy var tableViewNews = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    private func setUpUI() {
        self.view.backgroundColor = Configuration.Color.viewBackground
        configureNavigationBarTitle()
        configureSearchController()
        configureTableView()
    }

    private func configureNavigationBarTitle() {
        let attributes = [NSAttributedString.Key.foregroundColor: Configuration.Color.titleColor, NSAttributedString.Key.font : UIFont(name: Configuration.Font.medium.rawValue, size: 24)!]
        self.navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
    }

    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search news"
        navigationItem.searchController = searchController
    }
    
    private func configureTableView() {
        self.view.addSubview(tableViewNews)
        tableViewNews.translatesAutoresizingMaskIntoConstraints = false
         tableViewNews.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        tableViewNews.backgroundColor = Configuration.Color.clearColor
        tableViewNews.dataSource = self
        tableViewNews.delegate = self
        tableViewNews.register(NewsCell.self, forCellReuseIdentifier: NewsCell.reuseID)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseID,for: indexPath) as! NewsCell
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsDetailVC = NewsDetailVC()
        print("geçtik")
        navigationController?.pushViewController(newsDetailVC, animated: true)
    }
}
