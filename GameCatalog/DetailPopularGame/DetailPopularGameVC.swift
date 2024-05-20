//
//  DetailPopularGameVC.swift
//  GameCatalog
//
//  Created by Mahatmaditya FRS on 14/05/24.
//

import UIKit
import SwiftUI

class DetailPopularGameVC: UIViewController {
    
    var gameFetch: GameDetail? = nil
    var game: Game? = nil
    var gameId: Int!
    
    private let scrollView: UIScrollView = {
       var sv = UIScrollView()
        
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    
    private let containerView: UIView = {
       var view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let imageShadow: UIView = {
        let shadow = InnerShadowView()
        
        shadow.backgroundColor = .clear
        shadow.frame = CGRect(x: 0, y: 0, width: 430, height: 497)
//        shadow.layer.cornerRadius = 30
        shadow.translatesAutoresizingMaskIntoConstraints = false
        
        return shadow
    }()
    
    private let gameTitleLabel: UILabel = {
        var label = UILabel()
        
        label.textColor = UIColor(named: "textColor")
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        
        return label
    }()
    
    private let introductionLabel: UILabel = {
        var label = UILabel()
        
        label.textColor = UIColor(named: "textColor")
        label.text = "Introduction"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        return label
    }()
    
    private let backgroundImage: UIImageView = {
        var iv = UIImageView()
        
        return iv
    }()
    
    private let releasedLabel: UILabel = {
        var label = UILabel()
        
        label.textColor = UIColor(named: "textColor")
        label.font = UIFont.systemFont(ofSize: 24)
        
        return label
    }()
    
    private let genresLabel: UILabel = {
        var label = UILabel()
        
        label.textColor = UIColor(named: "textColor")
        label.font = UIFont.systemFont(ofSize: 18)
        
        return label
    }()
    
    private let gameScreenshots: UIImageView = {
        let iv = UIImageView()
        
        return iv
    }()
    
    let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        
        indicator.color = .gray
        
        return indicator
    }()
    
    private let gameDescriptionLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor(named: "textColor")
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    
    let ratingStarsView = StarsRatingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "background")
        
        configureScrollView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Task { await getDetailGames()}
    }
    
    func set(game: GameDetail) {
        gameTitleLabel.text = game.name
        gameDescriptionLabel.text = game.description
        ratingStarsView.rating = Float(game.rating)
    }
    
    fileprivate func startDownload(gameDetail: GameDetail) {
        let downloader: ImageDownloader = ImageDownloader()
        
        Task {
            do {
                let image = try await downloader.downloadImage(url: gameDetail.backgroundImage)
                
                gameDetail.image = image
                DispatchQueue.main.async {
                    self.backgroundImage.image = gameDetail.image
                }
                
            } catch {
                gameDetail.image = nil
            }
        }
    }
    
    func getDetailGames() async {
        let network = NetworkService()
        
        do {
            gameFetch = try await network.getGameDetails(gameId: gameId)
            updateUI()
            startDownload(gameDetail: gameFetch!)
        } catch {
            fatalError("Error: connection failed.")
        }
    }
    
    func updateUI() {
        guard let gameDetail = gameFetch else { return }
        
        DispatchQueue.main.async {
            self.gameTitleLabel.text = gameDetail.name
            self.gameDescriptionLabel.text = gameDetail.description
            self.ratingStarsView.rating = Float(gameDetail.rating)
        }
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
                
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        configureContainerView()
        
    }
    
    func configureContainerView() {
        let scrollFrameGuide = scrollView.frameLayoutGuide
        scrollView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            
            containerView.leadingAnchor.constraint(equalTo: scrollFrameGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollFrameGuide.trailingAnchor),
//            containerView.heightAnchor.constraint(equalToConstant: 1500)
            
        ])
        
        configureBackgroundImage()
        configureImageShadow()
        configureGameTitle()
        configureRatingStarsView()
        configureIntroductionLabel()
        configureGameDescription()
    }
    
    func configureBackgroundImage() {
        containerView.addSubview(backgroundImage)
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
//            backgroundImage.widthAnchor.constraint(equalToConstant: 430),
            backgroundImage.heightAnchor.constraint(equalToConstant: 497)
        ])
    }
    
    func configureImageShadow() {
        containerView.addSubview(imageShadow)
        
        NSLayoutConstraint.activate([
            imageShadow.topAnchor.constraint(equalTo: backgroundImage.topAnchor),
            imageShadow.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor),
            imageShadow.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor),
            imageShadow.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor)
        ])
        
    }
    
    func configureGameTitle() {
        containerView.addSubview(gameTitleLabel)
        
        gameTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        gameTitleLabel.numberOfLines = 3
        gameTitleLabel.lineBreakMode = .byWordWrapping
        
        
        NSLayoutConstraint.activate([
            gameTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 34),
            gameTitleLabel.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -47),
            gameTitleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 220)
        ])
    }
    
    func configureGenres() {
        containerView.addSubview(genresLabel)
        
        genresLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            genresLabel.topAnchor.constraint(equalTo: gameTitleLabel.bottomAnchor, constant: 6),
            genresLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 34)
        ])
    }
    
    func configureReleasedDate() {
        containerView.addSubview(releasedLabel)
        
        releasedLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            releasedLabel.leadingAnchor.constraint(equalTo: gameTitleLabel.trailingAnchor, constant: 10),
            releasedLabel.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -47)
        ])
    }
    
    func configureRatingStarsView() {
        containerView.addSubview(ratingStarsView)
        
        ratingStarsView.rating = 3.5
        
        ratingStarsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ratingStarsView.centerYAnchor.constraint(equalTo: gameTitleLabel.centerYAnchor),
            ratingStarsView.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -34)
        ])
    }
    
    func configureGameDescription() {
        containerView.addSubview(gameDescriptionLabel)
        
        gameDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        gameDescriptionLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            gameDescriptionLabel.topAnchor.constraint(equalTo: introductionLabel.bottomAnchor, constant: 10),
            gameDescriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 34),
            gameDescriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -34),
            gameDescriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -30)
        ])
    }
    
    func configureIntroductionLabel() {
        containerView.addSubview(introductionLabel)
        
        introductionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            introductionLabel.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: 32),
            introductionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 34)
        ])
    }
    
}

