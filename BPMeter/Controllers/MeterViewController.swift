//
//  ViewController.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 29/02/2020.
//  Copyright © 2020 Jakub Majkowski. All rights reserved.
//

import UIKit
import AVFoundation

class MeterViewController: UIViewController {

    let counter = Counter()
    let systemSoundID: SystemSoundID = 1105
    let generator = UIImpactFeedbackGenerator(style: .light)
    
    @IBOutlet weak var bpmLabel: UILabel!
    
    @objc func mainTap(sender: UITapGestureRecognizer) {
        counter.onTap()
        bpmLabel.text = String(Int(counter.calculate()))
        Animator.animateBackground(ofView: view)
        AudioServicesPlaySystemSound(systemSoundID)
        if Setup.vibrationsEnabled {
            self.generator.impactOccurred()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bpmLabel.adjustsFontSizeToFitWidth = true
        Setup.setupGradient(inView: view)
        let tap = UITapGestureRecognizer(target: self, action: #selector(mainTap(sender:)))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        bpmLabel.text = "Start tapping"
        counter.reset()
    }
    
}

