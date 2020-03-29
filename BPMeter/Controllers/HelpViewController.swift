//
//  HelpViewController.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 29/03/2020.
//  Copyright © 2020 Jakub Majkowski. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {

    @IBOutlet weak var highlightView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if !UIAccessibility.isReduceTransparencyEnabled {
            view.backgroundColor = .clear
            let blurEffect = UIBlurEffect(style: .regular)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.insertSubview(blurEffectView, at: 0)
        } else {
            view.backgroundColor = .systemTeal
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = self.view.bounds
            gradientLayer.colors = [UIColor.clear.cgColor, UIColor.systemPurple.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
            self.view.layer.insertSublayer(gradientLayer, at: 0)
        }
        
        highlightView.layer.cornerRadius = 10
    }
}
