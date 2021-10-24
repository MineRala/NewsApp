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
    var searchApi: [Articles] = []

    func loadNews(page: Int) {
        service.getTopNews(page: page) { result in
            self.delegate?.apiRequestCompleted()
            switch result {
            case .success(let news):
                page == 1 ? self.news = news : self.news.append(contentsOf: news)
                self.delegate?.apiRequestCompleted()
            case .failure(let error):
                print(error)
            }

        }
    }

    func loadNewsBySearch(query: String, page: Int) {
        service.getNewsBySearch(with:query, page: page) { result in
            self.delegate?.apiRequestCompleted()
            switch result {
            case .success(let news):
                page == 1 ? self.news = news : self.news.append(contentsOf: news)
                self.delegate?.apiRequestCompleted()
            case .failure(let error):
                print(error)
            }

        }
    }

    func getNumberOfRowsInNewsList() -> Int {
        return news.count
    }
}
