//
//  NewsVC.swift
//  NewsApp
//
//  Created by Mine Rala on 20.10.2021.
//

import UIKit
import Kingfisher

class NewsVC: UIViewController {

    private lazy var tableViewNews = UITableView()
    var viewModel = NewsViewModel()
    var searchNewsText: String = ""
    var page: Int = 1
    var pageSearch: Int = 1
    private lazy var searchVC = UISearchController(searchResultsController: nil)
}

//MARK: - Lifecycle
extension NewsVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        viewModel.delegate = self
        viewModel.topNewsFetched(page: 1)
    }
}

//MARK: - SetUpUI
extension NewsVC {
    private func setUpUI() {
        self.view.backgroundColor = Configure.Color.viewBackground
        configureNavigationBarTitle()
        configureSearchBar()
        configureTableView()
    }
}

//MARK: - Configure
extension NewsVC {
    private func configureNavigationBarTitle() {
        let attributes = [NSAttributedString.Key.foregroundColor: Configure.Color.titleColor, NSAttributedString.Key.font : UIFont(name: Configure.Font.medium.rawValue, size: 24)!]
        self.navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
    }

    private func configureSearchBar() {
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
        searchVC.searchBar.placeholder = NSLocalizedString("Search News", comment: "")
    }

    private func configureTableView() {
        self.view.addSubview(tableViewNews)
        tableViewNews.translatesAutoresizingMaskIntoConstraints = false
        tableViewNews.separatorStyle = .none
        tableViewNews.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            }
        tableViewNews.backgroundColor = Configure.Color.clearColor
        tableViewNews.dataSource = self
        tableViewNews.delegate = self
        tableViewNews.register(NewsCell.self, forCellReuseIdentifier: NewsCell.reuseID)
    }
}


//MARK: - Pagination
extension NewsVC {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - height {
            if searchNewsText.isEmpty {
                page += 1
                self.viewModel.topNewsFetched(page: self.page)
            } else {
                pageSearch += 1
                viewModel.newsBySearchFetched(query: searchNewsText, page: pageSearch)
            }
        }
    }
}
//MARK: - NewsViewModel Delegate
extension NewsVC: NewsViewModelDelegate {
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
}

//MARK: - SearchBar Delegate
extension NewsVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        viewModel.newsBySearchFetched(query: text, page: 1)
        self.searchVC.dismiss(animated: true, completion: nil)
        print(text)
        searchNewsText = text
        print(searchNewsText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.topNewsFetched(page: 1)
        self.searchVC.dismiss(animated: true, completion: nil)
    }

}

//MARK: - TableView Delegate & Datasource
extension NewsVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRowsInNewsList()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseID,for: indexPath) as! NewsCell
        cell.selectionStyle = .none
        let news = viewModel.news[indexPath.row]
        cell.setCell(title: news.title ?? "", description: news.description ?? "")
        let url = URL(string: viewModel.news[indexPath.row].image ?? "")
        cell.newsImage.kf.setImage(with: url, placeholder: UIImage(named: Configure.IconImage.placeholder))
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
