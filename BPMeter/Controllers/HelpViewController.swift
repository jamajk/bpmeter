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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if !UIAccessibility.isReduceTransparencyEnabled {
            Setup.setupBlur(inView: view)
        } else {
            Setup.setupGradient(inView: view)
        }
        highlightView.layer.cornerRadius = 10
    }
}
