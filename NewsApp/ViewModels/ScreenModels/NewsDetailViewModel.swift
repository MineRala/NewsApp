//
//  NewsDetailModel.swift
//  NewsApp
//
//  Created by Mine Rala on 21.10.2021.
//

import Foundation

final class NewsDetailViewModel {

  //  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var service = NetworkManager.shared

    var news: Articles!

    func makeFavoriteNews() {
      //  let favoriteNews = NewsItem()
    }
}


////MARK: - Core Data
//extension NewsDetailViewModel {
//
//    func favoriteNews() {
//        let newFavoriteNews = FavoriteNewsItem(context: context)
//        newFavoriteNews.author = news?.author
//        newFavoriteNews.content = news?.content
//        newFavoriteNews.image = news?.image
//        newFavoriteNews.newsDescription = news?.description
//        newFavoriteNews.publishDate = news?.publishDate
//        newFavoriteNews.title = news?.title
//        newFavoriteNews.urlLink = news?.urlLink
//
//        do {
//            try context.save()
//
//        } catch {
//            print("coreData error")
//        }
//    }
//}
