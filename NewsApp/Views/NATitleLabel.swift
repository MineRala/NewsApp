//
//  NACellTitleLabel.swift
//  NewsApp
//
//  Created by Mine Rala on 21.10.2021.
//

import UIKit

class NATitleLabel: UILabel {

   override init(frame: CGRect) {
       super.init(frame: frame)
   }

   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }

   init(fontSize: CGFloat) {
       super.init(frame: .zero)
       self.font = UIFont(name: Configuration.Font.bold.rawValue, size: fontSize)
       configure()
   }
}

//MARK: - Configure
extension NATitleLabel {
   private func configure() {
    textColor = Configuration.Color.titleColor
    adjustsFontSizeToFitWidth = true
    numberOfLines = 0
    minimumScaleFactor = 0.9
    lineBreakMode = .byTruncatingTail
    translatesAutoresizingMaskIntoConstraints = false
   }

}
