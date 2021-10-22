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
    private lazy var newsTitle = NATitleLabel(fontSize: 20)
    private lazy var newsDescription = NADescriptionLabel(fontSize: 12)
    private lazy var newsImage = NAAvatarImageView(frame: .zero)
    private lazy var padding: CGFloat = 8

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureCell() {
        self.contentView.addSubview(newsTitle)
        self.contentView.addSubview(newsDescription)
        self.contentView.addSubview(newsImage)

        newsTitle.text = "Yazı, ağızdan çıkan seslerin, fikirlerin ve görüşlerin mimik yardımı olmaksızın iletilmesini sağlayan,insanlar tarafından bulunan belirli işaret ve işaret sistemleri"
        newsDescription.text = "İnsanların dil bilme yetisinin bir ürünü olan yazı, ifadelerin kayda geçmesinde ve diğer insanlara iletilmesinde kullanılan bir dizi form ve işaretten meydana gelir. Bu form ve işaretler dizisi icat edildiği günden bu zamana kadar çeşitli yüzeyler üzerinde bulunur.Yazının tarihi bu yüzeyler ile olan etkileşimiyle oldukça ilişkilidir.Yazı malzemelerinin incelenmesi yardımıyla yazının tarihi süreçteki bölgesel gelişimi gözlemlenebilir."

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

        newsImage.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(newsTitle.snp.top)
            make.left.equalTo(newsDescription.snp.right).offset(padding/2)

        }

    }
}
