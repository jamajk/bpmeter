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
        if isToggled {
            timer.invalidate()
            startTimer(withTime: getTime())
        }
    }
    @IBAction func pressedStart(_ sender: Any) {
        isToggled = !isToggled
        
        if isToggled {
            //startButton.isSelected = true
            print("timer started")
            startTimer(withTime: getTime())
        }
        else {
            timer.invalidate()
            print("timer finished")
            //startButton.isSelected = false
        }
    }
    
    private func getTime() -> Double {
        let bpm = Int(stepper.value)
        let time = metronome.calctuateTime(speed: bpm)
        return time
    }
    
    private func startTimer(withTime: Double) {
        
        timer = Timer.scheduledTimer(withTimeInterval: withTime, repeats: true, block: {_ in
            
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut,  .allowUserInteraction], animations: {self.view.backgroundColor = UIColor.lightGray; self.view.backgroundColor = UIColor.systemTeal}, completion: nil)
            AudioServicesPlaySystemSound(self.systemSoundID)
        })
    }
    
    @objc func pan(gesture: UIPanGestureRecognizer) {
        let yTranslation = gesture.translation(in: gesture.view).y
        let tolerance: CGFloat = 10.0
        
        print(yTranslation)
        
        if abs(yTranslation) >= tolerance {
            let newValue = stepper.value - Double(yTranslation / tolerance)
            print("stepper value \(stepper.value)")
            stepper.value = newValue
            print("stepper value new \(stepper.value)")
            valueChange(stepper!)
            gesture.setTranslation(.zero, in: gesture.view)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tempoLabel.text = String(Int(stepper.value))
        stepper.isHidden = true
        
        view.backgroundColor = .systemTeal
        
        let gradientLayer = CAGradientLayer()

        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.systemPurple.cgColor]

        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(pan(gesture:)))
        pan.minimumNumberOfTouches = 2
        view.addGestureRecognizer(pan)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
        isToggled = false
        print("timer finished")
    }
}
