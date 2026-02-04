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

@Observable
class MetronomeViewModel {
    @ObservationIgnored
    private let client: MetronomeClientProtocol
    @ObservationIgnored
    private let audioPlayer: AudioPlayerClientProtocol
    @ObservationIgnored
    private let hapticClient: HapticFeedbackClientProtocol
    @ObservationIgnored
    private let settingsClient: SettingsClientProtocol
    @ObservationIgnored
    private var subscribers = Set<AnyCancellable>()

    private(set) var background: BackgroundState = .normal

    var buttonState: StartButtonState {
        client.isRunning ? .stop : .start
    }

    var currentBPM: Int {
        client.bpm
    }

    var currentBeatsPerMeasure: Int {
        client.beatsPerMeasure
    }

    init(
        client: MetronomeClientProtocol,
        audioPlayer: AudioPlayerClientProtocol,
        hapticClient: HapticFeedbackClientProtocol,
        settingsClient: SettingsClientProtocol
    ) {
        self.client = client
        self.audioPlayer = audioPlayer
        self.hapticClient = hapticClient
        self.settingsClient = settingsClient

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

    func stopPlaybackIfNeeded() {
        if client.isRunning {
            client.stopIfRunning()
        }
    }

    func onBPMChanged(to newValue: Int) {
        client.bpm = newValue
    }

    func onBeatsPerMeasureChanged(to newValue: Int) {
        client.beatsPerMeasure = newValue
    }

    private func onMetronomeTick(type: BeatType) {
        handleTickBackgroundColorChange()
        if settingsClient.isAudioOn {
            audioPlayer.playTickingSound(accented: type == .accented)
        }
        if settingsClient.isHapticFeedbackOn {
            hapticClient.vibrate()
        }
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
