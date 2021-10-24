//
//  NewsDetailVC.swift
//  NewsApp
//
//  Created by Mine Rala on 21.10.2021.
//

import UIKit
import SafariServices

class NewsDetailVC: UIViewController, SFSafariViewControllerDelegate {
    private lazy var newsTitle = NATitleLabel(fontSize: 16)
    private lazy var newsDescription = NATextView()
    private lazy var newsImage = NAAvatarImageView(frame: .zero)
    private lazy var newsButton = NAButton(backgroundColor: Configuration.Color.buttonBackgroundColor, title: "News Source", textColor: Configuration.Color.buttonTextColor)
    private lazy var padding: CGFloat = 8

    var viewModel = NewsDetailViewModel()

    private lazy var newsInfoStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 36
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var authorNameView = NAView(viewType: .authorNameView, text: "")
    private lazy var dateView = NAView(viewType: .dateView, text: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setData()
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

        newsImage.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(padding)
            make.right.equalToSuperview().offset(-padding)
            make.top.equalToSuperview().offset(padding)
            make.height.equalTo(view.snp.height).multipliedBy(0.45)
        }

        newsTitle.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(padding)
            make.right.equalToSuperview().offset(-padding)
            make.top.equalTo(newsImage.snp.bottom).offset(padding)
            make.height.equalTo(view.snp.height).multipliedBy(0.08)
        }

        newsInfoStack.snp.makeConstraints { (make) in
            make.top.equalTo(newsTitle.snp.bottom).offset(8)
            make.width.equalTo(view.snp.width).multipliedBy(0.9)
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
        newsButton.addTarget(self, action: #selector(newsSourceTapped), for: .touchUpInside)
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

    private func setData() {
        let url = URL(string: viewModel.news?.image ?? "")
        newsImage.kf.setImage(with: url, placeholder: Configuration.IconImage.placeholder)
        newsTitle.text = viewModel.news?.title
        authorNameView.textLabel.text = viewModel.news?.author ?? "Unknown Author"
        dateView.textLabel.text = viewModel.news?.publishDate ?? "Unknown Date"
        newsDescription.text = viewModel.news?.description ?? "Unknown Content"
    }

    @objc func shareButtonTapped() {
        if let title = viewModel.news?.title, let author = viewModel.news.author, let newsWebsiteURL = NSURL(string: (viewModel.news?.urlLink)!) {
        let shareNews = [title, author, newsWebsiteURL] as [Any]
        let shareActivityViewController = UIActivityViewController(activityItems: shareNews, applicationActivities: nil)
        self.present(shareActivityViewController, animated: true, completion: nil)
        }
    }

    @objc func favoriteButtonTapped() {
        showToast(title: "Favorite news", text: "This news has been added to your favorite list.", delay: 2)
        viewModel.makeFavoriteNews()
    }

    @objc func newsSourceTapped() {
        guard let url = URL(string: (viewModel.news?.urlLink)!) else {
            print(NAError.invalidURLLink)
            return
        }
        let websiteVC = SFSafariViewController(url: url)
        websiteVC.delegate = self
        present(websiteVC, animated: true)
    }

    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
}
