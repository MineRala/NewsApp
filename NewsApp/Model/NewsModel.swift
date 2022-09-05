//
//  NewsModel.swift
//  NewsApp
//
//  Created by Mine Rala on 21.10.2021.
//

import Foundation

struct NewsModel: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Articles]
}
