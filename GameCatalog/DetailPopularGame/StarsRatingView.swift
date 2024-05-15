//
//  StarsRatingView.swift
//  GameCatalog
//
//  Created by Mahatmaditya FRS on 14/05/24.
//

import Foundation
import UIKit

class StarsRatingView: UIStackView {
    
    var rating: Float = 0 {
        didSet {
            updateStars()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        distribution = .fillEqually
        spacing = 2
        
        for _ in 0..<5 {
            let starImageView = UIImageView()
            
            starImageView.contentMode = .scaleAspectFit
            starImageView.tintColor = UIColor(named: "starColor")
            
            starImageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
            starImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
            
            addArrangedSubview(starImageView)
        }
        
        updateStars()
        
    }
    
    private func updateStars() {
        let fullStarImage = UIImage(systemName: "star.fill")
        let halfStarImage = UIImage(systemName: "star.leadinghalf.filled")
        let emptyStarImage = UIImage(systemName: "star")
        
        let fullStarCount = Int(rating)
        let hasHalfStar = rating.truncatingRemainder(dividingBy: 1) > 0
        
        for (index, subview) in arrangedSubviews.enumerated() {
            let starImageView = subview as! UIImageView
            if index < fullStarCount {
                starImageView.image = fullStarImage
            } else if (index == fullStarCount && hasHalfStar) {
                starImageView.image = halfStarImage
            } else {
                starImageView.image = emptyStarImage
            }
        }
    }
    
}
