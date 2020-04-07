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
    
    @IBOutlet weak var bpmLabel: UILabel!
    
    @objc func mainTap(sender: UITapGestureRecognizer) {
        counter.Tap()
        bpmLabel.text = String(Int(counter.Calculate()))
        Animator.animateBackground(ofView: view)
        AudioServicesPlaySystemSound(systemSoundID)
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
        counter.Reset()
    }
    
}

