//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Mine Rala on 22.10.2021.
//

import UIKit

class NetworkManager {
    //Applied Singleton
    static let shared = NetworkManager()
    private let baseURL = "https://newsapi.org/v2"
    private let apiKey = "123da82d5c134728a45e68e935faf611"

    private init() {}

    func getNews(keyword: String, page: Int, completed: @escaping (Result<[Articles], NAError>) -> Void) {
        let byKeywordEndpoint = "\(baseURL)/everything?q=\(keyword)&page=\(page)&apiKey=\(apiKey)"

        guard let url = URL(string: byKeywordEndpoint) else {
            completed(.failure(.invalidKeyword))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let news = try decoder.decode(NewsModel.self, from: data)
                completed(.success(news.articles))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }

}

