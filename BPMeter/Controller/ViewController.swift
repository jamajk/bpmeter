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
    @IBOutlet weak var mainButton: UIButton!
    
    @IBAction func mainTap(_ sender: Any) {
        counter.Tap()
        bpmLabel.text = String(Int(counter.Calculate()))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bpmLabel.adjustsFontSizeToFitWidth = true
        bpmLabel.text = "Start tapping"
        mainButton.layer.cornerRadius = 15
        mainButton.layer.borderWidth = 10
        mainButton.layer.borderColor = UIColor.systemBlue.cgColor
    }


}

