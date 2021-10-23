//
//  ErrorMessage.swift
//  NewsApp
//
//  Created by Mine Rala on 22.10.2021.
//

import Foundation

enum NAError: String, Error {
    case invalidKeyword = "Invalid keyword. Please try again"
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case invalidURLLink = "Invalid link. Please check the link."
}

