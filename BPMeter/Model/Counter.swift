//
//  Counter.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 01/03/2020.
//  Copyright © 2020 Jakub Majkowski. All rights reserved.
//

import Foundation

class Counter: ObservableObject {
    
    private var tapCount = 0
    private var timePassed: [Double] = []
    
    private let maxCount = 6
    
    private var timerStart: DispatchTime
    private var timerFinish: DispatchTime

    @Published public var tempo: Double = 0
    
    init() {
        timerFinish = DispatchTime.now()
        timerStart = timerFinish
    }
    
    func onTap() {
        tapCount += 1
        
        if tapCount == 1 {
            timerStart = DispatchTime.now()
        }
        else {
            timerFinish = DispatchTime.now()
            let nanoTime = timerFinish.uptimeNanoseconds - timerStart.uptimeNanoseconds
            let secTime = Double(nanoTime) / 1_000_000_000
            
            if secTime < 2.0 {
                timePassed.append(secTime)
                
                if timePassed.count > maxCount {
                    timePassed.remove(at: 0)
                }
            } else {
                reset()
            }
            
            timerStart = timerFinish
        }

        self.tempo = calculateTempo()
    }
    
    func calculateTempo() -> Double {
        var result: Double = 0
        if timePassed.count > 0 {
            var avgTime: Double = 0.0
            for i in 1...timePassed.count {
                avgTime += timePassed[i - 1] / Double(timePassed.count)
            }
           result = 60.0 / avgTime
        }
        return result.rounded()
    }
    
    func reset() {
        timePassed.removeAll()
        tapCount = 0
    }
}
