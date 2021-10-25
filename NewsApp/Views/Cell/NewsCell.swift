//
//  NewsCell.swift
//  NewsApp
//
//  Created by Mine Rala on 21.10.2021.
//

import UIKit
import SnapKit

class NewsCell: UITableViewCell {
    static let reuseID = "NewsCell"
    lazy var newsTitle = NATitleLabel(fontSize: 20)
    lazy var newsDescription = NADescriptionLabel(fontSize: 12)
    lazy var newsImage = NAAvatarImageView(frame: .zero)
    private lazy var padding: CGFloat = 8
    private lazy var cornerRadius: CGFloat = 16

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Configuration.Color.cellBackgroundColor
        view.layer.cornerRadius = cornerRadius
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        newsTitle.text = nil
        newsDescription.text = nil
        newsImage.image = nil
    }

    private func configureCell() {
        self.contentView.addSubview(containerView)
        self.containerView.addSubview(newsTitle)
        self.containerView.addSubview(newsDescription)
        self.containerView.addSubview(newsImage)

        containerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(padding)
            make.bottom.equalToSuperview().offset(-padding)
            make.left.equalToSuperview().offset(padding)
            make.right.equalToSuperview().offset(-padding)
        }

        newsTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(padding)
            make.height.equalToSuperview().multipliedBy(0.35)
            make.width.equalToSuperview().multipliedBy(0.7)
        }

        newsDescription.snp.makeConstraints { (make) in
            make.top.equalTo(newsTitle.snp.bottom)
            make.bottom.equalToSuperview().offset(-padding)
            make.left.equalToSuperview().offset(padding)
            make.width.equalToSuperview().multipliedBy(0.7)
        }

        newsImage.layer.cornerRadius = cornerRadius
        newsImage.clipsToBounds = true
        newsImage.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-padding)
            make.right.equalToSuperview().offset(-padding)
            make.top.equalTo(newsTitle.snp.top).offset(padding)
            make.left.equalTo(newsDescription.snp.right).offset(padding)
        }
    }

    func setCell(title: String, description: String) {
        newsTitle.text = title
        newsDescription.text = description
    }
}
