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
    
    @IBOutlet weak var feedbackSwitch: UISwitch!
    
    @IBAction func feedbackToggled(_ sender: UISwitch) {
        
        if sender.isOn {
            Setup.vibrationsEnabled = true
            UserDefaults.standard.set(true, forKey: "feedbackEnable")
        }
        else {
            Setup.vibrationsEnabled = false
            UserDefaults.standard.set(false, forKey: "feedbackEnable")
        }
        UserDefaults.standard.set(sender.isOn, forKey: "hapticState")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedbackSwitch.isOn =  UserDefaults.standard.bool(forKey: "hapticState")
        if !UIAccessibility.isReduceTransparencyEnabled {
            Setup.setupBlur(inView: view)
        } else {
            Setup.setupGradient(inView: view)
        }
        highlightView.layer.cornerRadius = 10
    }
}
