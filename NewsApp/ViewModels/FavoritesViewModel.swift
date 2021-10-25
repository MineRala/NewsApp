//
//  FavotitesModel.swift
//  NewsApp
//
//  Created by Mine Rala on 21.10.2021.
//

import UIKit
import CoreData

class FavoritesTableViewModel {

    let context = AppDelegate.content
    var favoritedNews: [FavoriteNewsItem] = []

    init() {
        getFavoritedNewsItem()
    }

    func getFavoritedNewsItem() {
        do {
            favoritedNews = try context.fetch(FavoriteNewsItem.fetchRequest())
        } catch {
            print(NAError.coreDataError)
        }
    }

    func deleteFavoriteNewsItem(item: FavoriteNewsItem) {
        context.delete(item)
        do {
            try context.save()
        } catch {
            print(NAError.coreDataError)
        }
    }

    func checkNewsItemData(with title: String, completion: @escaping (Result<Bool, NAError>) -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteNewsItem")
        fetchRequest.predicate = NSPredicate(format: "newsTitle == %@", title)

        do {
            let newsCount = try context.count(for: fetchRequest)
            if newsCount > 0 {
                completion(.success(true))
            } else {
                completion(.success(false))
            }
        } catch {
            completion(.failure(.checkingError))
        }
    }
}
