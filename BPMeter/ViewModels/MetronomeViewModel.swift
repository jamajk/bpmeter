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
    case start
    case stop
}

enum BackgroundState {
    case normal
    case tickActive
}

@Observable
class MetronomeViewModel {
    @ObservationIgnored
    private let client: MetronomeClient
    @ObservationIgnored
    private let audioPlayer: AudioPlayerClient
    @ObservationIgnored
    private var subscribers = Set<AnyCancellable>()

    private(set) var buttonState: StartButtonState = .start
    private(set) var background: BackgroundState = .normal

    var currentBPM: Int {
        client.bpm
    }

    var currentBeatsPerMeasure: Int {
        client.beatsPerMeasure
    }

    init(
        client: MetronomeClient,
        audioPlayer: AudioPlayerClient
    ) {
        self.client = client
        self.audioPlayer = audioPlayer

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
        handleTickBackgroundColorChange()
        audioPlayer.playTickingSound(accented: type == .accented) // TODO: Fix the sounds so they don't have a delay
    }

    @MainActor
    private func handleTickBackgroundColorChange() {
        Task {
            background = .tickActive
            try await Task.sleep(for: .milliseconds(100))
            background = .normal
        }
    }
}
