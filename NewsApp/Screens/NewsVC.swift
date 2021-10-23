//
//  NewsVC.swift
//  NewsApp
//
//  Created by Mine Rala on 20.10.2021.
//

import UIKit
import Kingfisher

class NewsVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, NewsViewModelDelegate {
    func apiRequestCompleted() {
        DispatchQueue.main.async {
        self.tableViewNews.reloadData()
        //   self.dismissLoadingView()
        }
    }
    
    private lazy var tableViewNews = UITableView()
    var viewModel = NewsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        viewModel.delegate = self
        viewModel.loadNews(key: "apple", page: 1)
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
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search news"
        navigationItem.searchController = searchController
    }
    
    private func configureTableView() {
        self.view.addSubview(tableViewNews)
        tableViewNews.translatesAutoresizingMaskIntoConstraints = false
        tableViewNews.separatorStyle = .none
         tableViewNews.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        tableViewNews.backgroundColor = Configuration.Color.clearColor
        tableViewNews.dataSource = self
        tableViewNews.delegate = self
        tableViewNews.register(NewsCell.self, forCellReuseIdentifier: NewsCell.reuseID)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRowsInNewsList()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseID,for: indexPath) as! NewsCell
        cell.selectionStyle = .none
        let news = viewModel.news[indexPath.row]
        cell.setCell(title: news.title, description: news.description)
        let url = URL(string: viewModel.news[indexPath.row].image ?? "")
        cell.newsImage.kf.setImage(with: url, placeholder: Configuration.IconImage.placeholder)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let newsDetailVC = NewsDetailVC()
        newsDetailVC.viewModel.news = viewModel.news[indexPath.row]
        navigationController?.pushViewController(newsDetailVC, animated: true)
    }
}
