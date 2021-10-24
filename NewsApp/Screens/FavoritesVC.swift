//
//  FavoritesViewController.swift
//  NewsApp
//
//  Created by Mine Rala on 20.10.2021.
//

import UIKit
import SnapKit

class FavoritesVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private lazy var tableViewFavorites = UITableView()
    private lazy var emptyListLabel = NATitleLabel(fontSize: 24)

    let viewModel = FavoritesTableViewModel()

    override func viewDidLoad() {
    super.viewDidLoad()
        setUpUI()
    }

    func setUpUI() {
    self.view.backgroundColor = Configuration.Color.viewBackground
        configureNavigationBarTitle()
        configureTableView()
        configureEmptyListLabel()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableViewFavorites.frame = view.bounds
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getFavoritedNews()
        reloadTableView()
    }

    private func configureNavigationBarTitle() {
        let attributes = [NSAttributedString.Key.foregroundColor: Configuration.Color.titleColor, NSAttributedString.Key.font : UIFont(name: Configuration.Font.medium.rawValue, size: 24)!]
        self.navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
    }

    private func configureTableView() {
        self.view.addSubview(tableViewFavorites)
            tableViewFavorites.translatesAutoresizingMaskIntoConstraints = false
            tableViewFavorites.backgroundColor = Configuration.Color.clearColor
            tableViewFavorites.dataSource = self
            tableViewFavorites.delegate = self
            tableViewFavorites.register(NewsCell.self, forCellReuseIdentifier: NewsCell.reuseID)
    }

    private func configureEmptyListLabel() {
        emptyListLabel.backgroundColor = Configuration.Color.clearColor
        emptyListLabel.textAlignment = .center
        emptyListLabel.adjustsFontForContentSizeCategory = true
        emptyListLabel.text = "Your favorite news list is empty!"

        self.view.addSubview(emptyListLabel)
        emptyListLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    private func reloadTableView() {
        if viewModel.favoritedNews.count == 0 {
            tableViewFavorites.alpha = 0
            emptyListLabel.alpha = 1
        } else {
            tableViewFavorites.alpha = 1
            emptyListLabel.alpha = 0
        }
        tableViewFavorites.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favoritedNews.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseID,for: indexPath) as! NewsCell
        cell.selectionStyle = .none
        let cellItem = viewModel.favoritedNews[indexPath.row]
        let url = URL(string: cellItem.newsImage ?? "")
        cell.selectionStyle = .none
        cell.newsTitle.text = cellItem.newsTitle
        cell.newsDescription.text = cellItem.newsDescription
        cell.newsImage.kf.setImage(with: url, placeholder: Configuration.IconImage.placeholder)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let newsDetailVC = NewsDetailVC()
        let favoriteNewsArray = viewModel.favoritedNews[indexPath.row]
        let favoriteNews = Articles(source: Source(id: "", name: ""),
                                    author: favoriteNewsArray.newsAuthor,
                                    title: favoriteNewsArray.newsTitle,
                                    description: favoriteNewsArray.newsDescription,
                                    urlLink: favoriteNewsArray.newsUrlLink,
                                    image: viewModel.favoritedNews[indexPath.row].newsImage,
                                    publishDate: favoriteNewsArray.newsPublishDate,
                                    content: favoriteNewsArray.newsContent)
        newsDetailVC.viewModel.news = favoriteNews
        navigationController?.pushViewController(newsDetailVC, animated: true)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Delete") { [weak self] (action, view, completionHandler) in
            guard let self = self else{
                completionHandler(false)
                return
            }

            self.handleDelete(indexPath: indexPath)
            completionHandler(true)
        }

        delete.backgroundColor = .red

        let configuration = UISwipeActionsConfiguration(actions: [delete])
        return configuration
    }

    private func handleDelete(indexPath: IndexPath) {
        Alerts.showAlertDelete(controller: self, "Are you sure you want to delete this news from favorite list?") {
            [self] in
            self.viewModel.deleteFavoriteNews(item: self.viewModel.favoritedNews[indexPath.row])
            viewModel.getFavoritedNews()
            tableViewFavorites.deleteRows(at: [indexPath], with: .fade)
            reloadTableView()
        }

    }
}
