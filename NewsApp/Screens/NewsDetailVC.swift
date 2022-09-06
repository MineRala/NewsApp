//
//  NewsDetailVC.swift
//  NewsApp
//
//  Created by Mine Rala on 21.10.2021.
//

import UIKit
import SafariServices

class NewsDetailVC: UIViewController {
    private lazy var newsTitle = NATitleLabel(fontSize: 16)
    private lazy var newsDescription = NATextView()
    private lazy var newsImage = NAAvatarImageView(frame: .zero)
    private lazy var newsButton = NAButton(backgroundColor: Configure.Color.buttonBackgroundColor, title: NSLocalizedString("News Source", comment: ""), textColor: Configure.Color.buttonTextColor)
    private lazy var padding: CGFloat = 8

    let viewModel = NewsDetailViewModel()

    private lazy var newsInfoStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 36
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let backButton = UIBarButtonItem()
    private lazy var favoriteButton = UIBarButtonItem()
    private lazy var shareButton = UIBarButtonItem()

    private lazy var authorNameView = NAView(viewType: .authorNameView)
    private lazy var dateView = NAView(viewType: .dateView)
}

//MARK: - Lifecycle
extension NewsDetailVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.checkIsNewsFavorite() { [weak self] (isFavorite) in
            guard let self = self else { return }
            if isFavorite {
                self.favoriteButton.image = UIImage(systemName: Configure.IconImage.favoritesFillIcon)
            } else {
                self.favoriteButton.image = UIImage(systemName: Configure.IconImage.favoritesIcon)
            }
        }
    }
}

//MARK: - SetUpUI
extension NewsDetailVC {
    private func setUpUI() {
        self.view.backgroundColor = Configure.Color.viewBackground
        configureNavigationBar()
        self.view.addSubview(newsImage)
        self.view.addSubview(newsTitle)
        self.view.addSubview(newsInfoStack)
        self.view.addSubview(newsDescription)
        self.view.addSubview(newsButton)

        self.newsInfoStack.addArrangedSubview(authorNameView)
        self.newsInfoStack.addArrangedSubview(dateView)

        newsImage.backgroundColor = Configure.Color.clearColor
        newsTitle.backgroundColor = Configure.Color.clearColor
        newsDescription.backgroundColor = Configure.Color.clearColor

        newsImage.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
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
}

//MARK: - Configure NavigattionBar
extension NewsDetailVC {
    private func configureNavigationBar() {
        self.navigationController!.navigationBar.tintColor = Configure.Color.titleColor
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        favoriteButton = UIBarButtonItem(image: UIImage(systemName: Configure.IconImage.favoritesIcon), style: .plain, target: self, action: #selector(favoriteButtonTapped))
        shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButtonTapped))
        shareButton.tintColor = Configure.Color.blackColor
        navigationItem.rightBarButtonItems = [favoriteButton, shareButton]
    }
}

//MARK: - Set Data
extension NewsDetailVC {
    private func setData() {
        let url = URL(string: viewModel.news?.image ?? "")
        newsImage.kf.setImage(with: url, placeholder: UIImage(named: Configure.IconImage.placeholder))
        newsTitle.text = viewModel.news?.title
        authorNameView.setText(text: viewModel.news?.author  ?? NSLocalizedString("Unknown Author", comment: ""))
        dateView.setText(text: viewModel.news?.publishDate ?? NSLocalizedString("Unknown Date", comment: ""))
        newsDescription.text = viewModel.news?.description ?? NSLocalizedString("Unknown Description", comment: "")
    }
}

//MARK: - Actions
extension NewsDetailVC {
    @objc func shareButtonTapped() {
        if let title = viewModel.news?.title, let author = viewModel.news.author, let newsWebsiteURL = NSURL(string: (viewModel.news?.urlLink)!) {
        let shareNews = [title, author, newsWebsiteURL] as [Any]
        let shareActivityViewController = UIActivityViewController(activityItems: shareNews, applicationActivities: nil)
        self.present(shareActivityViewController, animated: true, completion: nil)
        }
    }

    @objc func favoriteButtonTapped() {
        viewModel.checkIsNewsFavorite() { [weak self] (isFavorite) in
            guard let self = self else { return }
            if isFavorite {
                Alerts.showAlert(controller: self, title: NSLocalizedString("Warning", comment: ""), message: NSLocalizedString("You have added this news to your favorite list before. You cannot add it again.", comment: "")) {}
                return
            } else {
                self.favoriteButton.image = UIImage(systemName: Configure.IconImage.favoritesFillIcon )
                self.showToast(title: NSLocalizedString("Favorite news", comment: ""), text: NSLocalizedString("This news has been added to your favorite list.", comment: ""), delay: 2)
                self.viewModel.makeFavoriteNews()
            }
        }
    }
}

//MARK: - SafariViewController Delegate
extension NewsDetailVC: SFSafariViewControllerDelegate {
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
