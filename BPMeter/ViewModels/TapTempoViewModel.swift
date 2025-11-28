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
    private let client = TapTempoClient()

    @ObservationIgnored
    private var resetTask: Task<Void, Error>?

    var bpmValue: Int {
        client.roundedBPM
    }

    func onTap() {
        removeResetTaskIfNeeded()
        client.onTapReceived()
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
}
