//
//  ViewController.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 29/02/2020.
//  Copyright © 2020 Jakub Majkowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let counter = Counter()
    
    
    @IBOutlet weak var bpmLabel: UILabel!
    
    @objc func mainTap(sender: UITapGestureRecognizer) {
        counter.Tap()
        bpmLabel.text = String(Int(counter.Calculate()))
        
        UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseInOut,  .allowUserInteraction], animations: {self.view.backgroundColor = UIColor.lightGray; self.view.backgroundColor = UIColor.systemTeal}, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bpmLabel.adjustsFontSizeToFitWidth = true
        bpmLabel.text = "Start tapping"
        view.backgroundColor = .systemTeal
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.systemPurple.cgColor]

        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)

        let tap = UITapGestureRecognizer(target: self, action: #selector(mainTap(sender:)))
        view.addGestureRecognizer(tap)
    }


}

