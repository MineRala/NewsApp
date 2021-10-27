//
//  NAView.swift
//  NewsApp
//
//  Created by Mine Rala on 22.10.2021.
//

import UIKit

enum ViewType {
    case authorNameView
    case dateView
}

class NAView: UIView {

    lazy var textLabel = NATitleLabel(fontSize: 14)
    private lazy var iconImage = NAAvatarImageView(frame: .zero)
    let padding: CGFloat = 8
    var viewType: ViewType = .authorNameView

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(viewType: ViewType) {
        super.init(frame: .zero)
        self.viewType = viewType
        configure(viewType: viewType)
    }
}

//MARK: - Configure
extension NAView {
    private func configure(viewType: ViewType) {
        self.addSubview(textLabel)
        self.addSubview(iconImage)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 20
        layer.masksToBounds = true
        textLabel.minimumScaleFactor = 0.5
        backgroundColor = Configuration.Color.titleColor
        textLabel.textColor = Configuration.Color.viewBackground

        iconImage.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(padding)
            make.width.equalToSuperview().multipliedBy(0.15)
            make.height.equalToSuperview().multipliedBy(0.5)
        }

        textLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(iconImage.snp.right).offset(padding)
            make.right.equalToSuperview().offset(-padding)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
    }
}

//MARK: - Set Text
extension NAView {
    func setText(text: String) {
        if viewType == .authorNameView {
            iconImage.image = UIImage(systemName: Configuration.IconImage.authorIcon)
            textLabel.text = text
        } else {
            iconImage.image = UIImage(systemName: Configuration.IconImage.calendarIcon)
            textLabel.text = text.convertToDisplayFormat()
        }
    }
}
