//
//  MetronomeClient.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 27/11/2025.
//

import Foundation
import Combine

enum BeatType {
    case accented
    case normal
}

@Observable
class MetronomeClient {
    struct Constants {
        static let startingBPM: Int = 120
        static let startingBeatsPerMeasure: Int = 4
    }

    var bpm: Int {
        didSet { restartTimerIfRunning() }
    }

    var beatsPerMeasure: Int {
        didSet { currentBeat = 1; restartTimerIfRunning() }
    }

    @ObservationIgnored
    private(set) var isRunning: AnyPublisher<Bool, Never>
    @ObservationIgnored
    private(set) var tick: AnyPublisher<BeatType, Never>

    init(
        bpm: Int = Constants.startingBPM,
        beatsPerMeasure: Int = Constants.startingBeatsPerMeasure
    ) {
        self.bpm = bpm
        self.beatsPerMeasure = beatsPerMeasure

        isRunning = isRunningSubject.eraseToAnyPublisher()
        tick = tickSubject.eraseToAnyPublisher()
    }

    private let tickSubject = PassthroughSubject<BeatType, Never>()
    private let isRunningSubject = CurrentValueSubject<Bool, Never>(false)
    private var timer: AnyCancellable?
    private var currentBeat: Int = 1

    // MARK: - Internal functions

    func onTapStartStop() {
        if isRunningSubject.value {
            timer?.cancel()
            timer = nil
            isRunningSubject.send(false)
            currentBeat = 1
        } else {
            guard bpm > 0 else { return }
            isRunningSubject.send(true)
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
        if isRunningSubject.value {
            timer?.cancel()
            startTimer()
        }
    }

    private func handleTick() {
        let isAccent = currentBeat == 1
        tickSubject.send(isAccent ? .accented : .normal)
        currentBeat += 1
        if currentBeat > beatsPerMeasure {
            currentBeat = 1
        }
    }
}
