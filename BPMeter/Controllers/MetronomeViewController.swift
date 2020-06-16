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
    let generator = UIImpactFeedbackGenerator(style: .light)
     
    var timer = Timer()
    var isToggled: Bool = false
    
    
    @IBOutlet weak var tempoLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var indicator: UIView!
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBAction func valueChange(_ sender: Any) {
        tempoLabel.text = String(Int(stepper.value))
        if isToggled {
            timer.invalidate()
            startTimer(withTime: getTime())
        }
    }
    @IBAction func pressedStart(_ sender: Any) {
        isToggled = !isToggled
        
        if isToggled {
            startTimer(withTime: getTime())
        }
        else {
            endTimer()
        }
    }
    
    private func getTime() -> Double {
        let bpm = Int(stepper.value)
        let time = metronome.calctuateTime(speed: bpm)
        return time
    }
    
    private func startTimer(withTime: Double) {
        indicator.backgroundColor = .green
        indicator.layer.shadowOpacity = 1
        timer = Timer.scheduledTimer(withTimeInterval: withTime, repeats: true, block: {_ in
            if Setup.vibrationsEnabled {
                self.generator.impactOccurred()
            }
            Animator.animateBackground(ofView: self.view)
            AudioServicesPlaySystemSound(self.systemSoundID)
        })
    }
    
    private func endTimer() {
        timer.invalidate()
        indicator.backgroundColor = .darkGray
        indicator.layer.shadowOpacity = 0
    }
    
    @objc func pan(gesture: UIPanGestureRecognizer) {
        let yTranslation = gesture.translation(in: gesture.view).y
        let tolerance: CGFloat = 10.0
        
        print(yTranslation)
        
        if abs(yTranslation) >= tolerance {
            let newValue = stepper.value - Double(yTranslation / tolerance)
            stepper.value = newValue
            valueChange(stepper!)
            gesture.setTranslation(.zero, in: gesture.view)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoLabel.alpha = 0
        tempoLabel.text = String(Int(stepper.value))
        stepper.isHidden = true
        startButton.layer.cornerRadius = 10.0
        
        Setup.setupIndicator(indicator: indicator)
        Setup.setupGradient(inView: view)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(pan(gesture:)))
        pan.minimumNumberOfTouches = 2
        view.addGestureRecognizer(pan)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if isToggled {
            endTimer()
            isToggled = false
        }
    }
}
