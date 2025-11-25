//
//  TapTempoViewModel.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 25/11/2025.
//

import SwiftUI

@Observable
class TapTempoViewModel {

    private(set) var roundedBPM: Int = 0

    private var tapCount = 0
    private var strides: [Double] = [] // time passed between each tap

    private let maxCount = 6

    private var timerStart: DispatchTime
    private var timerFinish: DispatchTime

    private var resetTask: Task<Void, Error>?

    init() {
        timerStart = DispatchTime.now()
        timerFinish = DispatchTime.now()
    }

    func onTap() {
        removeResetTaskIfNeeded()
        tapCount += 1
        roundedBPM = Int(calculateBPM())
        setupResetTask()
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

    private func setupResetTask() {
        resetTask = Task {
            try await Task.sleep(for: .seconds(2))
            try Task.checkCancellation()
            roundedBPM = 0
            strides.removeAll()
            tapCount = 0
        }
    }

    private func removeResetTaskIfNeeded() {
        resetTask?.cancel()
        resetTask = nil
    }
}
