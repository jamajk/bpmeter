//
//  MetronomeViewController.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 22/03/2020.
//  Copyright © 2020 Jakub Majkowski. All rights reserved.
//

import UIKit
import AVFoundation

class MetronomeViewController: UIViewController {
    
    let metronome = Metronome()
    let systemSoundID: SystemSoundID = 1105
     
    var timer = Timer()
    var isToggled: Bool = false
    
    
    @IBOutlet weak var tempoLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var startButton: UIButton!
    
    @IBAction func valueChange(_ sender: Any) {
        tempoLabel.text = String(Int(stepper.value))
    }
    @IBAction func pressedStart(_ sender: Any) { //TODO Probably create a proper toggle button
        isToggled = !isToggled
        
        if isToggled {
            let bpm = Int(stepper.value)
            let time = metronome.calctuateTime(speed: bpm)
            
            //startButton.isSelected = true
            print("timer started")
            
            timer = Timer.scheduledTimer(withTimeInterval: time, repeats: true, block: {_ in
                print("tick")
                AudioServicesPlaySystemSound(self.systemSoundID)
            })
        }
        else {
            timer.invalidate()
            print("timer finished")
            //startButton.isSelected = false
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tempoLabel.text = String(Int(stepper.value))
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.systemTeal.cgColor, UIColor.systemPurple.cgColor]

        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
