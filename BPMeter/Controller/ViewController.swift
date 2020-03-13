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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bpmLabel.adjustsFontSizeToFitWidth = true
        bpmLabel.text = "Start tapping"
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.purple.cgColor]
        print(gradientLayer.startPoint)
        print(gradientLayer.endPoint)
        
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(mainTap(sender:)))
        view.addGestureRecognizer(tap)
    }


}

