//
//  NewsListModel.swift
//  NewsApp
//
//  Created by Mine Rala on 23.10.2021.
//

import Foundation

protocol NewsViewModelDelegate: AnyObject {
    func loadIndicatorForApiRequestCompleted()
    func dissmissIndicatorForApiRequestCompleted()
    func reloadTableViewAfterIndicator()
}

class NewsViewModel {
    
    weak var delegate: NewsViewModelDelegate?
    private var service = NetworkManager.shared
    
    var news: [Articles] = []

    func getNumberOfRowsInNewsList() -> Int {
        return news.count
    }
}

extension NewsViewModel: NetworkManagerDelegate {
    func topNewsFetched(page: Int) {
        self.delegate?.loadIndicatorForApiRequestCompleted()
        service.makeRequest(endpoint: .topNews(page: page), type: NewsModel.self) { result in
            self.delegate?.dissmissIndicatorForApiRequestCompleted()
            switch result {
            case .success(let news):
                page == 1 ? self.news = news.articles : self.news.append(contentsOf: news.articles)
                self.delegate?.reloadTableViewAfterIndicator()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func newsBySearchFetched(query: String, page: Int) {
        self.delegate?.loadIndicatorForApiRequestCompleted()
        service.makeRequest(endpoint: .newsBySearch(query: query, page: page), type:    NewsModel.self) { result in
            switch result {
            case .success(let news):
                page == 1 ? self.news = news.articles : self.news.append(contentsOf: news.articles)
                self.delegate?.reloadTableViewAfterIndicator()
            case .failure(let error):
                print(error)
            }
        }
    }
}
