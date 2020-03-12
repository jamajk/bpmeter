//
//  Counter.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 01/03/2020.
//  Copyright © 2020 Jakub Majkowski. All rights reserved.
//

import Foundation

class Counter {
    
    var tapCount = 0
    var timePassed: [Double] = []
    
    var timerStart: DispatchTime
    var timerFinish: DispatchTime
    
    init() {
        timerFinish = DispatchTime.now()
        timerStart = timerFinish
    }
    
    func Tap() {
        tapCount += 1
        
        if tapCount == 1 {
            timerStart = DispatchTime.now()
        }
        else {
            
            timerFinish = DispatchTime.now()
            let nanoTime = timerFinish.uptimeNanoseconds - timerStart.uptimeNanoseconds
            timePassed.append(Double(nanoTime) / 1000000000)
            if timePassed.count > 4 {
                timePassed.remove(at: 0)
            }
            print(timePassed.count)
            
            for i in 1...timePassed.count {
                print(timePassed[i - 1])
            }
            
            timerStart = timerFinish
        }
    }
    
    func Calculate() -> Double {
        var result: Double = 0
        if timePassed.count > 0 {
            var avgTime: Double = 0.0
            for i in 1...timePassed.count {
                avgTime += timePassed[i - 1] / Double(timePassed.count)
            }
           result = 60.0 / avgTime
        }
        print(result)
        return result.rounded()
    }
    
    func Reset() {
        timePassed.removeAll()
        tapCount = 0
    }
}
