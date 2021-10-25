//
//  NewsListModel.swift
//  NewsApp
//
//  Created by Mine Rala on 23.10.2021.
//

import Foundation

protocol NewsViewModelDelegate: class {
    func loadIndicatorForApiRequestCompleted()
    func dissmissIndicatorForApiRequestCompleted()
    func reloadTableViewAfterIndicator()
}

class NewsViewModel {

    weak var delegate: NewsViewModelDelegate?
    private var service = NetworkManager.shared

    var news: [Articles] = []

    func loadNews(page: Int) {
        self.delegate?.loadIndicatorForApiRequestCompleted()
        service.getTopNews(page: page) { result in
            self.delegate?.dissmissIndicatorForApiRequestCompleted()
            switch result {
            case .success(let news):
                page == 1 ? self.news = news : self.news.append(contentsOf: news)
                self.delegate?.reloadTableViewAfterIndicator()
            case .failure(let error):
                print(error)
            }

        }
    }

    func loadNewsBySearch(query: String, page: Int) {
        self.delegate?.loadIndicatorForApiRequestCompleted()
        service.getNewsBySearch(with:query, page: page) { result in
            self.delegate?.dissmissIndicatorForApiRequestCompleted()
            switch result {
            case .success(let news):
                page == 1 ? self.news = news : self.news.append(contentsOf: news)
                self.delegate?.reloadTableViewAfterIndicator()
            case .failure(let error):
                print(error)
            }

        }
    }

    func getNumberOfRowsInNewsList() -> Int {
        return news.count
    }
}
