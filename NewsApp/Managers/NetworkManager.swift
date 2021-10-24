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
    private let apiKey = "487234e8fe6d47deb1fbc95c256e5e8c"

    private init() {}

    func getTopNews(page: Int, completed: @escaping (Result<[Articles], NAError>) -> Void) {
        let headlinesEndPoint = "\(baseURL)/top-headlines?country=tr&page=\(page)&apiKey=\(apiKey)"

        guard let url = URL(string: headlinesEndPoint) else {
            completed(.failure(.invalidURL))
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

    func getNewsBySearch(with query: String, page: Int, completed: @escaping (Result<[Articles], NAError>) -> Void) {
        let byKeywordEndpoint = "\(baseURL)/everything?q=\(query)&page=\(page)&apiKey=\(apiKey)"

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

