//
//  NewsListModel.swift
//  NewsApp
//
//  Created by Mine Rala on 23.10.2021.
//

import Foundation

protocol NewsViewModelDelegate: class {
    func apiRequestCompleted()
}

class NewsViewModel {

    weak var delegate: NewsViewModelDelegate?
    private var service = NetworkManager.shared

    var news: [Articles] = []

    func loadNews(key: String?, page: Int) {
        service.getNews(keyword: key ?? "home", page: page) { [weak self] result in
            self!.delegate?.apiRequestCompleted()
            switch result {
            case .success(let news):
                page == 1 ? self!.news = news : self!.news.append(contentsOf: news)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func getNumberOfRowsInNewsList() -> Int {
        return news.count
    }
}
