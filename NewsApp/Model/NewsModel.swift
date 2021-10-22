//
//  NewsModel.swift
//  NewsApp
//
//  Created by Mine Rala on 21.10.2021.
//

import Foundation

struct NewsModel: Codable {
    let status: String
    let totalResults: Int
    let articles: [Articles]

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case articles = "articles"
        case totalResults = "totalResults"
    }
}
