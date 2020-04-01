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
            
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut,  .allowUserInteraction], animations: {self.view.backgroundColor = UIColor.lightGray; self.view.backgroundColor = UIColor.systemTeal}, completion: nil)
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
        setupIndicator()
        setupGradient()
        let pan = UIPanGestureRecognizer(target: self, action: #selector(pan(gesture:)))
        pan.minimumNumberOfTouches = 2
        view.addGestureRecognizer(pan)
        
        UIView.animate(withDuration: 0.5, delay: 2.0, options: [], animations: {
            self.infoLabel.alpha = 1
        }, completion: {_ in
            UIView.animate(withDuration: 0.5, delay: 3.0, options: [], animations: { //oh no
                self.infoLabel.alpha = 0
            }, completion: {_ in})
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if isToggled {
            endTimer()
            isToggled = false
        }
    }
    
    private func setupGradient() {
        view.backgroundColor = .systemTeal
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.systemPurple.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupIndicator() {
        indicator.layer.cornerRadius = 5.0
        indicator.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        indicator.layer.shadowColor = UIColor.green.cgColor
        indicator.layer.shadowRadius = 5.0
        indicator.layer.shadowOpacity = 0
    }
}
