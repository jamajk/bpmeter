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
        
        let anim = UIViewPropertyAnimator(duration: 0.2, dampingRatio: 1, animations: {self.view.backgroundColor = UIColor.lightGray})
        anim.addCompletion({_ in
            let anim2 = UIViewPropertyAnimator(duration: 0.1, dampingRatio: 1, animations: {self.view.backgroundColor = UIColor.init(displayP3Red: 0.35, green: 0.78, blue: 0.98, alpha: 1.0)})
            anim2.startAnimation()
        })
        anim.startAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bpmLabel.adjustsFontSizeToFitWidth = true
        bpmLabel.text = "Start tapping"
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.init(displayP3Red: 0.35, green: 0.78, blue: 0.98, alpha: 1.0), UIColor.systemPurple.cgColor]

        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)

        let tap = UITapGestureRecognizer(target: self, action: #selector(mainTap(sender:)))
        view.addGestureRecognizer(tap)
    }


}

