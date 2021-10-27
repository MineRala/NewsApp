//
//  NACellDescriptionLabel.swift
//  NewsApp
//
//  Created by Mine Rala on 21.10.2021.
//

import UIKit

class NADescriptionLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        self.font = UIFont(name: Configuration.Font.regular.rawValue, size: fontSize)
        configure()
    }
}

//MARK: - Configure
extension NADescriptionLabel {
    private func configure() {
        textColor = Configuration.Color.descriptionColor
        numberOfLines = 0
        minimumScaleFactor = 0.75
        translatesAutoresizingMaskIntoConstraints = false
    }

}
