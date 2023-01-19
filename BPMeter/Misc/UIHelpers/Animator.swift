//
//  Animator.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 07/04/2020.
//  Copyright © 2020 Jakub Majkowski. All rights reserved.
//

import UIKit

class Animator {
    static func animateBackground(ofView: UIView) {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut,  .allowUserInteraction], animations: {ofView.backgroundColor = UIColor.lightGray; ofView.backgroundColor = UIColor.adaptiveColorOne}, completion: nil)
    }
    
    static func animateText(ofLabel: UILabel) {
        //appearance
        UIView.animate(withDuration: 0.5, delay: 2.0, options: [], animations: {
            ofLabel.alpha = 1
        }, completion: {_ in
            //disappearance
            UIView.animate(withDuration: 0.5, delay: 3.0, options: [], animations: { //oh no
                ofLabel.alpha = 0
            }, completion: {_ in})
        })
    }
}
