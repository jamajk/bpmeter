//
//  Setup.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 07/04/2020.
//  Copyright © 2020 Jakub Majkowski. All rights reserved.
//

import UIKit

class Setup {
    
    static var vibrationsEnabled: Bool = UserDefaults.standard.bool(forKey: "feedbackEnable") 
    
    static func setupGradient(inView: UIView) {
        inView.backgroundColor = UIColor.adaptiveColorOne
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = inView.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.adaptiveColorTwo.cgColor]
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

extension UIColor {
    static let adaptiveColorOne: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return UIColor.black
                } else {
                    return UIColor.systemTeal
                }
            }
        } else {
            return UIColor.systemTeal
        }
    }()
    
    static let adaptiveColorTwo: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return UIColor.purple
                } else {
                    return UIColor.systemPurple
                }
            }
        } else {
            return UIColor.systemPurple
        }
    }()
}
