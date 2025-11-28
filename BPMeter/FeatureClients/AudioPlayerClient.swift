//
//  AudioPlayerClient.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 28/11/2025.
//

import AVFoundation

class AudioPlayerClient { // should probably split this file
    private var accentPlayer: AVAudioPlayer?
    private var normalPlayer: AVAudioPlayer?

    init() {
        loadAudio()
    }

    func playTickingSound(accented: Bool) {
        if accented {
            accentPlayer?.currentTime = 0
            accentPlayer?.play()
        } else {
            normalPlayer?.currentTime = 0
            normalPlayer?.play()
        }
    }

    private func loadAudio() {
        accentPlayer = loadSound(named: "tickAccent")
        normalPlayer = loadSound(named: "tickNormal")
    }

    private func loadSound(named name: String) -> AVAudioPlayer? {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            print("Missing sound: \(name).mp3")
            return nil
        }
        return try? AVAudioPlayer(contentsOf: url)
    }
}
