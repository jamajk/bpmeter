//
//  MetronomeViewModel.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 26/11/2025.
//

import Foundation
import Combine
import AVFoundation

enum StartButtonState {
    case stop
    case start
}

@Observable
class MetronomeViewModel {
    private let client: MetronomeClient
    private var subscribers = Set<AnyCancellable>()

    struct Constants {
        static let startingBPM: Int = 120
        static let startingBeatsPerMeasure: Int = 4
    }

    private(set) var buttonState: StartButtonState = .start
    private(set) var background: StartButtonState = .start

    init() {
        client = MetronomeClient(
            bpm: Constants.startingBPM,
            beatsPerMeasure: Constants.startingBeatsPerMeasure
        )

        client.isRunning
            .receive(on: RunLoop.main)
            .sink { [weak self] isRunning in
                guard let self else { return }
                self.updateButtonState(isMetronomeRunning: isRunning)
            }
            .store(in: &subscribers)

        client.tick
            .receive(on: RunLoop.main)
            .sink { [weak self] beatType in
                guard let self else { return }
                self.onMetronomeTick(type: beatType)
            }
            .store(in: &subscribers)
    }

    func onStartStopTapped() {
        client.onTapStartStop()
    }

    func onBPMChanged(to newValue: Int) {
        client.bpm = newValue
    }

    func onBeatsPerMeasureChanged(to newValue: Int) {
        client.beatsPerMeasure = newValue
    }

    private func updateButtonState(isMetronomeRunning: Bool) {
        buttonState = isMetronomeRunning ? .stop : .start
    }

    private func onMetronomeTick(type: BeatType) {
        // coś tam animacja
        // play sound
        print(type == .accented ? "Bim" : "Bom") // TODO: Finish
    }
}
