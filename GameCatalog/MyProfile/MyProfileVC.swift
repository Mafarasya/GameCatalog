//
//  MyProfileViewController.swift
//  GameCatalog
//
//  Created by Mahatmaditya FRS on 10/05/24.
//

import UIKit
import SwiftUI

class MyProfileVC: UIViewController {
        
    lazy var imageShadow: UIView = {
        let shadow = InnerShadowView()
        
        shadow.backgroundColor = .clear
        shadow.frame = CGRect(x: 0, y: 0, width: 430, height: 524)
        shadow.layer.cornerRadius = 30
        
        return shadow
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        
//        label.text = "Mahatmaditya \nFavian RS 🧑🏻‍💻"
        label.textColor = UIColor(named: "nameColor")
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        
        return label
    }()
    
    lazy var jobLabel: UILabel = {
        let label = UILabel()
        
        label.text = "iOS Developer at Dicoding Indonesia"
        label.textColor = UIColor(named: "jobTitleColor")
        
        return label
    }()
    
    lazy var myProfilePhoto: UIImageView = {
        let image = UIImageView()
        
        image.image = UIImage(named: "myPhoto")
        
        return image
    }()
    
    lazy var quotesLabel: UILabel = {
        var label = UILabel()
        
        label.textColor = UIColor(named: "textColor")
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "background")
        
        configureMyProfilePhoto()
        view.addSubview(imageShadow)
        configureNameLabel()
        configureJobLabel()
        configureQuotesLabel()
    }
    
    func configureMyProfilePhoto() {
        view.addSubview(myProfilePhoto)
        
        myProfilePhoto.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            myProfilePhoto.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myProfilePhoto.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func configureNameLabel() {
        view.addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.numberOfLines = 0
        nameLabel.lineBreakMode = .byWordWrapping
        
        let attributeString = NSMutableAttributedString(string: "Mahatmaditya \nFavian RS 🧑🏻‍💻")
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        
        attributeString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributeString.length))
        
        nameLabel.attributedText = attributeString
        
        NSLayoutConstraint.activate([
            nameLabel.bottomAnchor.constraint(equalTo: myProfilePhoto.bottomAnchor, constant: -55),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26)
        ])
    }
    
    func configureJobLabel() {
        view.addSubview(jobLabel)

        jobLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            jobLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 7),
            jobLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26)
        ])
    }
    
    func configureQuotesLabel() {
        view.addSubview(quotesLabel)
    
        quotesLabel.translatesAutoresizingMaskIntoConstraints = false
        quotesLabel.numberOfLines = 6
        quotesLabel.lineBreakMode = .byWordWrapping
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        
        quotesLabel.attributedText = NSMutableAttributedString(string: "\"I’m as proud of many of the things we haven’t done as the things we have done. Innovation is saying no to a thousand things.\" \n-Steve Jobs", attributes: [NSAttributedString.Key.kern: 1, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        quotesLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            quotesLabel.topAnchor.constraint(equalTo: myProfilePhoto.bottomAnchor, constant: 85),
            quotesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            quotesLabel.widthAnchor.constraint(equalToConstant: 353)
        ])
    }
    

}

#Preview {
    MyProfileVC()
}


class InnerShadowView: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 0).cgColor,
            UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 0.8).cgColor
        ]
        gradientLayer.locations = [0.63, 0.89]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 430, height: 524)
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 430, height: 524), cornerRadius: 30).cgPath
        gradientLayer.mask = maskLayer
        
        layer.addSublayer(gradientLayer)
    }
}
