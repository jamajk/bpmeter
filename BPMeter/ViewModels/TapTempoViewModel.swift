//
//  TapTempoViewModel.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 25/11/2025.
//

import SwiftUI

@Observable
class TapTempoViewModel {
    @ObservationIgnored
    private let client: TapTempoClientProtocol
    @ObservationIgnored
    private let audioPlayer: AudioPlayerClientProtocol
    @ObservationIgnored
    private let hapticClient: HapticFeedbackClientProtocol
    @ObservationIgnored
    private let settingsClient: SettingsClientProtocol
    @ObservationIgnored
    private var resetTask: Task<Void, Error>?

    private(set) var background: BackgroundState = .normal

    var floatingBallsViewModel: FloatingBallsViewModel
    var rippleOrigin: CGPoint = .zero
    var rippleTrigger: Bool = false

    var bpmValue: Int {
        client.roundedBPM
    }

    var isBPMDetected: Bool {
        bpmValue != .zero
    }

    init(
        client: TapTempoClientProtocol,
        audioPlayer: AudioPlayerClientProtocol,
        hapticClient: HapticFeedbackClientProtocol,
        settingsClient: SettingsClientProtocol
    ) {
        self.client = client
        self.audioPlayer = audioPlayer
        self.hapticClient = hapticClient
        self.settingsClient = settingsClient
        floatingBallsViewModel = FloatingBallsViewModel()
    }

    func onTap(origin: CGPoint) {
        removeResetTaskIfNeeded()
        rippleOrigin = origin
        rippleTrigger.toggle()
        floatingBallsViewModel.handleTap(at: origin)
        client.onTapReceived()
        if settingsClient.isAudioOn {
            audioPlayer.playTickingSound(accented: false)
        }
        if settingsClient.isHapticFeedbackOn {
            hapticClient.vibrate()
        }
        handleTickBackgroundColorChange()
        setupResetTask()
    }

    private func setupResetTask() {
        resetTask = Task {
            try await Task.sleep(for: .seconds(2))
            try Task.checkCancellation()
            client.resetCounter()
        }
    }

    private func removeResetTaskIfNeeded() {
        resetTask?.cancel()
        resetTask = nil
    }

    private func handleTickBackgroundColorChange() { // TODO: Unify this with metronome
        Task { @MainActor in
            background = .tickActive
            try await Task.sleep(for: .milliseconds(100))
            background = .normal
        }
    }
}
