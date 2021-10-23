//
//  NATextView.swift
//  NewsApp
//
//  Created by Mine Rala on 22.10.2021.
//

import UIKit

class NATextView: UITextView  {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        self.font = UIFont(name: Configuration.Font.regular.rawValue, size: 14)
        textColor = Configuration.Color.descriptionColor
        isScrollEnabled = true
        isEditable = false
        translatesAutoresizingMaskIntoConstraints = false
    }

}