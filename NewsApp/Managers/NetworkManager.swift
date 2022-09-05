//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Mine Rala on 22.10.2021.
//

import UIKit

protocol NetworkManagerProtocol {
    // var delegate: NetworkManagerDelegate? { get set }
    
    //    func makeRequest<T: Decodable>(endpoint: Endpoint, type: T.Type, completed: @escaping (Result<T, NAError>) -> Void)
    //    func makeRequest<T: Decodable>(endpoint: Endpoint, completed: @escaping (Result<T, NAError>) -> Void)
    func makeRequest(endpoint: Endpoint, completed: @escaping (Result<[Articles], NAError>) -> Void)
}


protocol NetworkManagerDelegate: AnyObject {
    func topNewsFetched(page: Int)
    func newsBySearchFetched(query: String, page: Int)
}

class NetworkManager {
    //Applied Singleton
    static let shared = NetworkManager()
    
    func makeRequest(endpoint: Endpoint, completed: @escaping (Result<[Articles], NAError>) -> Void) {
        guard let url = endpoint.url else {
            completed(.failure(.invalidKeyword))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
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
        }.resume()
    }
}

