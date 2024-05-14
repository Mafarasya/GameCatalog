//
//  InnerShadowBackgroundImage.swift
//  GameCatalog
//
//  Created by Mahatmaditya FRS on 14/05/24.
//

import Foundation
import UIKit

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
