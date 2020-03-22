//
//  Metronome.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 22/03/2020.
//  Copyright © 2020 Jakub Majkowski. All rights reserved.
//

import Foundation

class Metronome {
    var bpm: Int = 0
    
    func calctuateTime(speed: Int) -> Double {
        let time = Double(60 / speed)
        return time
    }
}
