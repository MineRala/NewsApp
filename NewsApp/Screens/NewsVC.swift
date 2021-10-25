//
//  NewsVC.swift
//  NewsApp
//
//  Created by Mine Rala on 20.10.2021.
//

import UIKit
import Kingfisher

class NewsVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, NewsViewModelDelegate {

    private lazy var tableViewNews = UITableView()
    var viewModel = NewsViewModel()
    var searchNewsText: String = ""
    var page: Int = 1
    var pageSearch: Int = 1
    private lazy var searchVC = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        viewModel.delegate = self
        viewModel.loadNews(page: 1)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    private func setUpUI() {
        self.view.backgroundColor = Configuration.Color.viewBackground
        configureNavigationBarTitle()
        createSearchBar()
        configureTableView()

    }

    private func configureNavigationBarTitle() {
        let attributes = [NSAttributedString.Key.foregroundColor: Configuration.Color.titleColor, NSAttributedString.Key.font : UIFont(name: Configuration.Font.medium.rawValue, size: 24)!]
        self.navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
    }

    private func createSearchBar() {
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
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

    func loadIndicatorForApiRequestCompleted() {
        DispatchQueue.main.async {
            self.showLoadingView()
        }
    }

    func dissmissIndicatorForApiRequestCompleted() {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + .milliseconds(30), execute: { [weak self] in
            self!.dismissLoadingView()
        })
    }

    func reloadTableViewAfterIndicator() {
        DispatchQueue.main.async {
            self.tableViewNews.reloadData()
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        viewModel.loadNewsBySearch(query: text, page: 1)
        self.searchVC.dismiss(animated: true, completion: nil)
        print(text)
        searchNewsText = text
        print(searchNewsText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.loadNews(page: 1)
        self.searchVC.dismiss(animated: true, completion: nil)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - height {
            if searchNewsText.isEmpty {
                page += 1
                self.viewModel.loadNews(page: self.page)
            } else {
                pageSearch += 1
                viewModel.loadNewsBySearch(query: searchNewsText, page: pageSearch)
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRowsInNewsList()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseID,for: indexPath) as! NewsCell
        cell.selectionStyle = .none
        let news = viewModel.news[indexPath.row]
        cell.setCell(title: news.title ?? "", description: news.description ?? "")
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
