//
//  SettingsViewModel.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 08/12/2025.
//

import SwiftUI

@Observable
class SettingsViewModel {
    private let storageClient: StorageClientProtocol

    init(storageClient: StorageClientProtocol) {
        self.storageClient = storageClient
    }
    
    var isAudioOn: Bool {
        get {
            storageClient.readValue(for: StorageKeys.isSoundOn)
        }
        set {
            storageClient.setValue(newValue, for: StorageKeys.isSoundOn)
        }
    }

    var isHapticFeedbackOn: Bool {
        get {
            storageClient.readValue(for: StorageKeys.isHapticFeedbackOn)
        }
        set {
            storageClient.setValue(newValue, for: StorageKeys.isHapticFeedbackOn)
        }
    }
}
