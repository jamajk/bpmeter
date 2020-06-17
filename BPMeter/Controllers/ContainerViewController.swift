//
//  ContainerViewController.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 22/04/2020.
//  Copyright © 2020 Jakub Majkowski. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    

    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.frame = CGRect(x: 0, y: 0, width: view.frame.maxX, height: view.frame.maxY)
    }
}

