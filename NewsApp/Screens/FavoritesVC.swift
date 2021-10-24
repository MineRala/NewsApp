//
//  FavoritesViewController.swift
//  NewsApp
//
//  Created by Mine Rala on 20.10.2021.
//

import UIKit
import SnapKit

protocol FavoritesVCInterface {
func setUpUI()
}

class FavoritesVC: UIViewController, UITableViewDataSource, UITableViewDelegate, FavoritesVCInterface {
    
    private lazy var tableViewFavorites = UITableView()
    let favorite : [NewsModel] = []


    private lazy var emptyListLabel = NATitleLabel(fontSize: 24)


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
      //  viewModel.getFavoritedNews()
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
        if favorite.count == 0 {
            tableViewFavorites.alpha = 0
            emptyListLabel.alpha = 1
        } else {
            tableViewFavorites.alpha = 1
            emptyListLabel.alpha = 0
        }
        tableViewFavorites.reloadData()
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
