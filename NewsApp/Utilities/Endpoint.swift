//
//  Endpoint.swift
//  NewsApp
//
//  Created by Mine Rala on 5.09.2022.
//

import Foundation

enum Endpoint {
    enum Constant {
        static let baseURL = "https://newsapi.org/v2"
        static let apiKey = "487234e8fe6d47deb1fbc95c256e5e8c"
    }
    
    case topNews(page: Int)
    case newsBySearch(query: String, page: Int)
    
    var url: URL? {
        switch self {
        case .topNews(let page):
            return URL(string: "\(Constant.baseURL)/top-headlines?country=tr&page=\(page)&apiKey=\(Constant.apiKey)")
        case .newsBySearch(let query, let page):
            return URL(string: "\(Constant.baseURL)/everything?q=\(query)&page=\(page)&apiKey=\(Constant.apiKey)")
        }
    }
}

