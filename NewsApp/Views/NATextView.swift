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
}

//MARK: - Configure
extension NATextView {
    private func configure() {
        self.font = UIFont(name: Configure.Font.regular.rawValue, size: 14)
        textColor = Configure.Color.descriptionColor
        isScrollEnabled = true
        isEditable = false
        translatesAutoresizingMaskIntoConstraints = false
    }

}
