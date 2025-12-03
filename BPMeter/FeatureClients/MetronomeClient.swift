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

protocol MetronomeClientProtocol: AnyObject {
    var bpm: Int { get set }
    var beatsPerMeasure: Int { get set }
    var isRunning: Bool { get }
    var tick: AnyPublisher<BeatType, Never> { get }

    func onTapStartStop()
    func stopIfRunning()
}

@Observable
class MetronomeClient: MetronomeClientProtocol {
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

    private(set) var isRunning: Bool = false

    @ObservationIgnored
    private(set) var tick: AnyPublisher<BeatType, Never>

    init(
        bpm: Int = Constants.startingBPM,
        beatsPerMeasure: Int = Constants.startingBeatsPerMeasure
    ) {
        self.bpm = bpm
        self.beatsPerMeasure = beatsPerMeasure

        tick = tickSubject.eraseToAnyPublisher()
    }

    private let tickSubject = PassthroughSubject<BeatType, Never>()
    private var timer: AnyCancellable?
    private var currentBeat: Int = 1

    // MARK: - Internal functions

    func onTapStartStop() {
        if isRunning {
            stopTimer()
        } else {
            guard bpm > 0 else { return }
            startTimer()
        }
    }

    func stopIfRunning() {
        if isRunning {
            stopTimer()
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
        isRunning = true
    }

    private func stopTimer() {
        isRunning = false
        timer?.cancel()
        timer = nil
        currentBeat = 1
    }

    private func restartTimerIfRunning() {
        if isRunning {
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
