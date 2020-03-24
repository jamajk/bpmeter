//
//  Metronome.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 22/03/2020.
//  Copyright © 2020 Jakub Majkowski. All rights reserved.
//

import Foundation

class Metronome {
    func calctuateTime(speed: Int) -> Double {
        let time = 60.0 / Double(speed)
        return time
    }
}
