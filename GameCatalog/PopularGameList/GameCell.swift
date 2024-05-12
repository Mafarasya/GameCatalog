//
//  GameListCell.swift
//  GameCatalog
//
//  Created by Mahatmaditya FRS on 11/05/24.
//

import UIKit
import SwiftUI

class GameCell: UITableViewCell {
    
    private let topSeparatorLine: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "textColor")
        
        return view
    }()
    
    private let botSeparatorLine: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "textColor")
        
        return view
    }()
    
    private let gameImageView : UIImageView = {
        let iv = UIImageView()
        
        iv.tintColor = .label
//        iv.image = UIImage(named: "myPhoto")
        return iv
    }()
    
    private let gameTitleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor(named: "textColor")
        
        return label
    }()
    
    private let releaseLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = UIColor(named: "textColor")

        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = UIColor(named: "textColor")

        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor(named: "background")
        
        addSubview(topSeparatorLine)
        addSubview(gameImageView)
        addSubview(gameTitleLabel)
        addSubview(releaseLabel)
        addSubview(ratingLabel)
        addSubview(botSeparatorLine)
        // Configure the view for the selected state
        configureTopSeparatorLine()
        configureImageView()
        configureGameTitleLabel()
        configureReleaseLabel()
        configureRatingLabel()
        configureBotSeparatorLine()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not be implemented")
    }
    
    func set(game: Game) {
        print("Setting up cell for game: \(game.gameTitle)")
        gameImageView.image = game.image
        gameTitleLabel.text = game.gameTitle
        releaseLabel.text = game.releaseDate
        ratingLabel.text = game.rating
    }

    func configureTopSeparatorLine(){
        topSeparatorLine.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topSeparatorLine.topAnchor.constraint(equalTo: topAnchor),
            topSeparatorLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            topSeparatorLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            topSeparatorLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func configureBotSeparatorLine(){
        botSeparatorLine.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            botSeparatorLine.bottomAnchor.constraint(equalTo: bottomAnchor),
            botSeparatorLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            botSeparatorLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            botSeparatorLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func configureImageView() {
        gameImageView.translatesAutoresizingMaskIntoConstraints = false
        
        gameImageView.layer.cornerRadius = 15
        gameImageView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            gameImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            gameImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 38),
            gameImageView.heightAnchor.constraint(equalToConstant: 100),
            gameImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func configureGameTitleLabel() {
        gameTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        gameTitleLabel.numberOfLines = 2
        gameTitleLabel.adjustsFontSizeToFitWidth = true
        gameTitleLabel.lineBreakMode = .byWordWrapping
        
        NSLayoutConstraint.activate([
            gameTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 23),
            gameTitleLabel.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: 26),
            gameTitleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 220)
        ])
    }
    
    func configureReleaseLabel() {
        releaseLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            releaseLabel.topAnchor.constraint(equalTo: gameTitleLabel.bottomAnchor, constant: 6),
            releaseLabel.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: 26)
        ])
    }
    
    func configureRatingLabel() {
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: releaseLabel.bottomAnchor, constant: 6),
            ratingLabel.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: 26)
        ])
    }
    
}

#Preview {
    GameCell()
}

