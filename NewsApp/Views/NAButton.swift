//
//  NAButton.swift
//  NewsApp
//
//  Created by Mine Rala on 22.10.2021.
//

import UIKit

class NAButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(backgroundColor: UIColor, title: String, textColor: UIColor) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        setTitleColor(textColor, for: .normal)
        configure()
    }
}

//MARK: - Configure
extension NAButton {
    private func configure() {
        layer.cornerRadius = 10
        titleLabel?.font = UIFont(name: Configure.Font.medium.rawValue, size: 16)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
