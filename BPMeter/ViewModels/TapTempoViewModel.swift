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
    private let client: TapTempoClient
    @ObservationIgnored
    private let audioPlayer: AudioPlayerClient
    @ObservationIgnored
    private var resetTask: Task<Void, Error>?
    private var viewportSize: CGSize?
    private var isAnimatingBubble: Bool = false

    private(set) var background: BackgroundState = .normal
    private(set) var bubbleXPosition: CGFloat = .zero
    private(set) var bubbleYPosition: CGFloat = .zero // TODO: More bubbles

    var bpmValue: Int {
        client.roundedBPM
    }

    var isBPMDetected: Bool {
        bpmValue != .zero
    }

    init(
        client: TapTempoClient,
        audioPlayer: AudioPlayerClient
    ) {
        self.client = client
        self.audioPlayer = audioPlayer
    }

    func onAppear() {
        isAnimatingBubble = true
    }

    func onDisappear() {
        isAnimatingBubble = false
    }

    func updateViewportSize(_ size: CGSize) {
        viewportSize = size
        animateBubble() // TODO: Simplify this logic
    }

    func onTap() {
        removeResetTaskIfNeeded()
        client.onTapReceived()
        audioPlayer.playTickingSound(accented: false)
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

    private func animateBubble() {
        Task { @MainActor in
            guard let viewportSize else { return }
            while isAnimatingBubble {
                let maxPointX = viewportSize.width
                let maxPointY = viewportSize.height
                let startingPositionX = CGFloat.random(in: 0...maxPointX)
                let startingPositionY = maxPointY + 60 // + radius so it's hidden
                bubbleXPosition = startingPositionX
                bubbleYPosition = startingPositionY
                withAnimation(.linear(duration: 10)) {
                    bubbleYPosition = -60
                }
                try? await Task.sleep(for: .seconds(10))
            }
        }
    }
}
