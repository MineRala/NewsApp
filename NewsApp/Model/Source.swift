//
//  Source.swift
//  NewsApp
//
//  Created by Mine Rala on 22.10.2021.
//

import Foundation

struct Source: Codable {
    let id: String?
    let name: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
