//
//  Configuration.swift
//  NewsApp
//
//  Created by Mine Rala on 21.10.2021.
//

import UIKit

//var KeyWindow : UIWindow { UIApplication.shared.windows.first(where: { $0.isKeyWindow })! }

struct Configuration {

    enum Font: String {
        case bold = "Montserrat-Bold"
        case medium = "Montserrat-Medium"
        case regular = "Montserrat-Regular"

        func font(_ size: CGFloat) -> UIFont {
            return UIFont(name: self.rawValue, size: size)!
        }
    }

    enum IconImage {
        static let newsImageSF = "newspaper"
        static let favoritesImageSF = "heart"
        static let calendarImageSF = "calendar"
        static let authorLaptopImageSF = "laptopcomputer"
        static let placeholder = UIImage(named: "newsImage")
        static let circleHeartImageSF = "heart.circle.fill"
    }

    struct Color {
        static var tabbarTintColor: UIColor {UIColor.black}
        static var clearColor: UIColor {UIColor.clear}
        static var viewBackground: UIColor {#colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)}
        static var titleColor: UIColor {#colorLiteral(red: 0.3254901961, green: 0.3254901961, blue: 0.3254901961, alpha: 1)}
        static var descriptionColor: UIColor {#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)}
        static var buttonTextColor: UIColor {#colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)}
        static var buttonBackgroundColor: UIColor {#colorLiteral(red: 0.3333333333, green: 0.3333333333, blue: 0.3333333333, alpha: 1)}


    }
}
