//
//  NewsDetailVC.swift
//  NewsApp
//
//  Created by Mine Rala on 21.10.2021.
//

import UIKit

class NewsDetailVC: UIViewController {
    private lazy var newsTitle = NATitleLabel(fontSize: 16)
    private lazy var newsDescription = NATextView()
    private lazy var newsImage = NAAvatarImageView(frame: .zero)
    private lazy var newsButton = NAButton(backgroundColor: Configuration.Color.buttonBackgroundColor, title: "News Source", textColor: Configuration.Color.buttonTextColor)
    private lazy var padding: CGFloat = 8

    private lazy var newsInfoStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 36
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var authorNameView = NAView(viewType: .authorNameView, text: "Mine Rala")
    private lazy var dateView = NAView(viewType: .dateView, text: "3 ağustos")

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    private func setUpUI() {
        self.view.backgroundColor = Configuration.Color.viewBackground
        configureNavigationBar()
        self.view.addSubview(newsImage)
        self.view.addSubview(newsTitle)
        self.view.addSubview(newsInfoStack)
        self.view.addSubview(newsDescription)
        self.view.addSubview(newsButton)


        self.newsInfoStack.addArrangedSubview(authorNameView)
        self.newsInfoStack.addArrangedSubview(dateView)

        newsImage.backgroundColor = Configuration.Color.clearColor
        newsTitle.backgroundColor = Configuration.Color.clearColor
        newsDescription.backgroundColor = Configuration.Color.clearColor

        newsTitle.text = "Yazı, ağızdan çıkan seslerin, fikirlerin ve görüşlerin mimik yardımı olmaksızın iletilmesini sağlayan,insanlar tarafından bulunan belirli işaret ve işaret sistemleri"
        newsDescription.text = "İnsanların dil bilme yetisinin bir ürünü olan yazı, ifadelerin kayda geçmesinde ve diğer insanlara iletilmesinde kullanılan bir dizi form ve işaretten meydana gelir. Bu form ve işaretler dizisi icat edildiği günden bu zamana kadar çeşitli yüzeyler üzerinde bulunur.Yazının tarihi bu yüzeyler ile olan etkileşimiyle oldukça ilişkilidir."

        newsImage.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(padding)
            make.right.equalToSuperview().offset(-padding)
            make.top.equalToSuperview().offset(padding)
            make.height.equalTo(view.snp.height).multipliedBy(0.4)
        }

        newsTitle.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(padding)
            make.right.equalToSuperview().offset(-padding)
            make.top.equalTo(newsImage.snp.bottom).offset(padding)
            make.height.equalTo(view.snp.height).multipliedBy(0.08)
        }

        newsInfoStack.snp.makeConstraints { (make) in
            make.top.equalTo(newsTitle.snp.bottom).offset(8)
            make.width.equalTo(view.snp.width).multipliedBy(0.75)
            make.centerX.equalToSuperview()
            make.height.equalTo(view.snp.height).multipliedBy(0.05)
        }

        newsDescription.snp.makeConstraints { (make) in
            make.top.equalTo(newsInfoStack.snp.bottom).offset(padding)
            make.left.equalTo(view.snp.left).offset(padding)
            make.right.equalTo(view.snp.right).offset(-padding)
            make.bottom.equalTo(newsButton.snp.top).offset(-padding)
        }

        newsButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-padding)
            make.height.equalTo(view.snp.height).multipliedBy(0.06)
        }
    }

    private func configureNavigationBar() {
        self.navigationController!.navigationBar.tintColor = Configuration.Color.titleColor
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        let favoriteButton = UIBarButtonItem(image: UIImage(systemName: Configuration.IconImage.favoritesImageSF), style: .plain, target: self, action: #selector(favoriteButtonTapped))
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButtonTapped))
        shareButton.tintColor = .black
        navigationItem.rightBarButtonItems = [favoriteButton, shareButton]
    }


    @objc func favoriteButtonTapped() {
        print("Favoride")
        showToast(message: "The news has been added to your favorite list.", font: UIFont(name: Configuration.Font.medium.rawValue, size: 16)!)
        }

        @objc func shareButtonTapped() {
        print("sharede")
    }

}
