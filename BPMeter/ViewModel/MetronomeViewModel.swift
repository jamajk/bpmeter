//
//  MetronomeViewModel.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 26/11/2025.
//

import Foundation
import Combine
import AVFoundation

enum BeatType {
    case accented
    case normal
}

@Observable
class MetronomeViewModel {
    private var timer: AnyCancellable?
    private var currentBeat: Int = 1

    let tick = PassthroughSubject<BeatType, Never>()
    var isRunning: Bool = false

    var bpm: Int {
        didSet { restartTimerIfRunning() }
    }

    var beatsPerMeasure: Int {
        didSet { currentBeat = 1; restartTimerIfRunning() }
    }

    init(bpm: Int = 120, beatsPerMeasure: Int = 4) {
        self.bpm = bpm
        self.beatsPerMeasure = beatsPerMeasure
    }

    // MARK: - Public API

    func onTapStartStop() {
        if isRunning {
            timer?.cancel()
            timer = nil
            isRunning = false
            currentBeat = 1
        } else {
            guard bpm > 0 else { return }
            isRunning = true
            startTimer()
        }
    }

    // MARK: - Private functions

    private func startTimer() {
        let interval = 60.0 / Double(bpm)

        timer = Timer
            .publish(every: interval, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.handleTick()
            }
    }

    private func restartTimerIfRunning() {
        if isRunning {
            timer?.cancel()
            startTimer()
        }
    }

    private func handleTick() {
        let isAccent = currentBeat == 1
        tick.send(isAccent ? .accented : .normal)
//        print(isAccent ? "Bim" : "Bom")
        currentBeat += 1
        if currentBeat > beatsPerMeasure {
            currentBeat = 1
        }
    }
}
