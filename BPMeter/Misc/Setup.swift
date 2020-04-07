//
//  Setup.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 07/04/2020.
//  Copyright © 2020 Jakub Majkowski. All rights reserved.
//

import UIKit

class Setup {
    
    static func setupGradient(inView: UIView) {
        inView.backgroundColor = .systemTeal
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = inView.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.systemPurple.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        inView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    static func setupIndicator(indicator: UIView) {
        indicator.layer.cornerRadius = 5.0
        indicator.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        indicator.layer.shadowColor = UIColor.green.cgColor
        indicator.layer.shadowRadius = 5.0
        indicator.layer.shadowOpacity = 0
    }
    
    static func setupBlur(inView: UIView) {
        inView.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = inView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        inView.insertSubview(blurEffectView, at: 0)
    }
}
