//
//  NewsDetailModel.swift
//  NewsApp
//
//  Created by Mine Rala on 21.10.2021.
//

import UIKit

final class NewsDetailViewModel {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var service = NetworkManager.shared

    var news: Articles!

        func makeFavoriteNews() {
            let favoriteNews = FavoriteNewsItem(context: context)
            favoriteNews.newsAuthor = news?.author
            favoriteNews.newsContent = news?.content
            favoriteNews.newsImage = news?.image
            favoriteNews.newsDescription = news?.description
            favoriteNews.newsPublishDate = news?.publishDate
            favoriteNews.newsTitle = news?.title
            favoriteNews.newsUrlLink = news?.urlLink

            do {
                try context.save()

            } catch {
                print("coreData error")
            }
        }

}

