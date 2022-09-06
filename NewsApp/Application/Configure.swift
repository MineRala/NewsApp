//
//  Configure.swift
//  NewsApp
//
//  Created by Mine Rala on 21.10.2021.
//

import UIKit

struct Configure {

    enum Font: String {
        case bold = "Montserrat-Bold"
        case medium = "Montserrat-Medium"
        case regular = "Montserrat-Regular"

        func font(_ size: CGFloat) -> UIFont {
            return UIFont(name: self.rawValue, size: size)!
        }
    }

    enum IconImage {
        static let placeholder = "icon"
        static let newsIcon = "newspaper"
        static let favoritesIcon = "heart"
        static let favoritesFillIcon = "heart.fill"
        static let calendarIcon = "calendar"
        static let authorIcon = "newspaper.fill"
    }

    struct Color {
        static var tabbarTintColor: UIColor {#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)}
        static var clearColor: UIColor {#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)}
        static var viewBackground: UIColor {#colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)}
        static var titleColor: UIColor {#colorLiteral(red: 0.3254901961, green: 0.3254901961, blue: 0.3254901961, alpha: 1)}
        static var descriptionColor: UIColor {#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)}
        static var buttonTextColor: UIColor {#colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)}
        static var buttonBackgroundColor: UIColor {#colorLiteral(red: 0.3333333333, green: 0.3333333333, blue: 0.3333333333, alpha: 1)}
        static var cellBackgroundColor: UIColor {#colorLiteral(red: 0.8430537581, green: 0.843195796, blue: 0.8430350423, alpha: 1)}
        static var redColor: UIColor {UIColor.red}
        static var blackColor: UIColor {UIColor.black}
    }
}
