//
//  SceneDelegate.swift
//  NewsApp
//
//  Created by Mine Rala on 20.10.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let ws = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: ws.coordinateSpace.bounds)
        window?.windowScene = ws
        window?.rootViewController = createTabbar()
        window?.makeKeyAndVisible()
    }

    private func createTabbar() -> UITabBarController {
        let tabbar = UITabBarController()
        UITabBar.appearance().tintColor = Configuration.Color.tabbarTintColor
        tabbar.viewControllers = [createNewsNC(),createFavoritesNC()]
        return tabbar
    }

    private func createNewsNC() -> UINavigationController {
        let newsVC = NewsVC()
        newsVC.title = NSLocalizedString("Appcent News App", comment: "")
        newsVC.tabBarItem = UITabBarItem(title: NSLocalizedString("News", comment: ""), image: UIImage(systemName: Configuration.IconImage.newsIcon), tag: 0)
        return UINavigationController(rootViewController: newsVC)
    }

    private func createFavoritesNC() -> UINavigationController {
        let favoritesNC = FavoritesVC()
        favoritesNC.title = NSLocalizedString("Favorites", comment: "")
        favoritesNC.tabBarItem = UITabBarItem(title: NSLocalizedString("Favorites", comment: ""), image: UIImage(systemName: Configuration.IconImage.favoritesIcon), tag: 1)
        return UINavigationController(rootViewController: favoritesNC)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

