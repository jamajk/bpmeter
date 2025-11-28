//
//  TapTempoClient.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 28/11/2025.
//
import SwiftUI

@Observable
class TapTempoClient {
    private(set) var roundedBPM: Int = 0

    @ObservationIgnored
    private var tapCount = 0
    @ObservationIgnored
    private var strides: [Double] = [] // time passed between each tap

    @ObservationIgnored
    private let maxCount = 6

    @ObservationIgnored
    private var timerStart: DispatchTime! // controversial
    @ObservationIgnored
    private var timerFinish: DispatchTime!

    func onTapReceived() {
        tapCount += 1
        roundedBPM = Int(calculateBPM())
    }

    func resetCounter() {
        roundedBPM = 0
        strides.removeAll()
        tapCount = 0
    }

    private func calculateBPM() -> Double {
        if tapCount == 1 {
            timerStart = DispatchTime.now()
        } else {
            timerFinish = DispatchTime.now()
            let nanoTime = timerFinish.uptimeNanoseconds - timerStart.uptimeNanoseconds
            let secTime = Double(nanoTime) / 1_000_000_000

            strides.append(secTime)

            if strides.count > maxCount {
                strides.remove(at: 0)
            }
            timerStart = timerFinish
        }

        var result: Double = 0
        if strides.count > 0 {
            var avgTime: Double = 0.0
            for i in 1...strides.count {
                avgTime += strides[i - 1] / Double(strides.count)
            }
           result = 60.0 / avgTime
        }
        return result.rounded()
    }
}
