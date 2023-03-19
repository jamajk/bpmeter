//
//  Metronome.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 22/03/2020.
//  Copyright © 2020 Jakub Majkowski. All rights reserved.
//

import SwiftUI

class Metronome: ObservableObject {

    var requiredTempo: Int = 0

    @Published var timeSpace: Int = 0

    func calctuateTime(speed: Int) -> Double {
        let time = 60.0 / Double(speed)
        return time
    }
}
