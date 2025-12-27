//
//  SettingsClient.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 27/12/2025.
//

import Foundation
import SwiftUI

// for read only settings reading
protocol SettingsClientProtocol: AnyObject {
    var isAudioOn: Bool { get }
    var isHapticFeedbackOn: Bool { get }
}

class SettingsClient: SettingsClientProtocol {
    private let storageClient: StorageClientProtocol

    init(storageClient: StorageClientProtocol) {
        self.storageClient = storageClient
    }

    var isAudioOn: Bool {
        storageClient.readValue(for: .isSoundOn)
    }

    var isHapticFeedbackOn: Bool {
        storageClient.readValue(for: .isHapticFeedbackOn) // TODO: First run should return true
    }
}
