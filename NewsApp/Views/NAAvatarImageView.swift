//
//  NAAvatarImageView.swift
//  NewsApp
//
//  Created by Mine Rala on 21.10.2021.
//

import UIKit

class NAAvatarImageView: UIImageView {

    var placeholderImage = UIImage(named: "volvo")!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        sizeToFit()
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }

}
