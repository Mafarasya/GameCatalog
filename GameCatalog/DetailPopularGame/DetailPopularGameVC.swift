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
    
    private let imageShadow: UIView = {
        let shadow = InnerShadowView()
        
        shadow.backgroundColor = .clear
        shadow.frame = CGRect(x: 0, y: 0, width: 430, height: 524)
        shadow.layer.cornerRadius = 30
        
        return shadow
    }()
    
    private let gameTitleLabel: UILabel = {
        var label = UILabel()
        
        label.textColor = UIColor(named: "textColor")
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
//        label.text = "Grand Theft Auto: San Andreas"
        
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
//        label.text =  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut dictum placerat massa nec pretium. In elementum arcu lectus. Donec eu lacus quam. Phasellus imperdiet tortor non orci tempor, sit amet varius mauris sagittis. Curabitur faucibus, massa eu venenatis fringilla, diam massa fermentum magna, vitae condimentum lectus orci eu turpis. Aliquam tempor enim non elit rhoncus malesuada. Pellentesque posuere semper eros"
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    
    let ratingStarsView = StarsRatingView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "background")
                
        configureBackgroundImage()
        view.addSubview(imageShadow)
        configureGameTitle()
//        configureReleasedDate()
        configureGenres()
        configureRatingStarsView()
        configureScreenshotsLabel()
        configureGameDescription()

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
    
    func configureBackgroundImage() {
        view.addSubview(backgroundImage)
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.widthAnchor.constraint(equalToConstant: 430),
            backgroundImage.heightAnchor.constraint(equalToConstant: 497)
        ])
    }
    
    func configureGameTitle() {
        view.addSubview(gameTitleLabel)
        
        gameTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        gameTitleLabel.numberOfLines = 3
        gameTitleLabel.lineBreakMode = .byWordWrapping
        
        
        NSLayoutConstraint.activate([
            gameTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34),
            gameTitleLabel.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -73),
            gameTitleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 220)
        ])
    }
    
    func configureGenres() {
        view.addSubview(genresLabel)
        
        genresLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            genresLabel.topAnchor.constraint(equalTo: gameTitleLabel.bottomAnchor, constant: 6),
            genresLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34)
        ])
    }
    
    func configureReleasedDate() {
        view.addSubview(releasedLabel)
        
        releasedLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            releasedLabel.leadingAnchor.constraint(equalTo: gameTitleLabel.trailingAnchor, constant: 10),
            releasedLabel.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -73)
        ])
    }
    
    func configureRatingStarsView() {
        view.addSubview(ratingStarsView)
        
        ratingStarsView.rating = 3.5
        
        ratingStarsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ratingStarsView.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: 296),
            ratingStarsView.centerYAnchor.constraint(equalTo: gameTitleLabel.centerYAnchor),
            ratingStarsView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -34)
        ])
    }
    
    func configureGameDescription() {
        view.addSubview(gameDescriptionLabel)
        
        gameDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        gameDescriptionLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            gameDescriptionLabel.topAnchor.constraint(equalTo: introductionLabel.bottomAnchor, constant: 10),
            gameDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34),
            gameDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -34)
        ])
    }
    
    func configureScreenshotsLabel() {
        view.addSubview(introductionLabel)
        
        introductionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            introductionLabel.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: 32),
            introductionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34)
        ])
    }
    
    func configureLoadingIndicator() {
        view.addSubview(loadingIndicator)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: backgroundImage.centerYAnchor)
        ])
        
    }
}

#Preview {
    DetailPopularGameVC()
}
