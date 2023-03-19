//
//  DefaultsStorage.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 23/01/2023.
//  Copyright © 2023 Jakub Majkowski. All rights reserved.
//

import Foundation
import SwiftUI

enum DefaultsKey: String {
    case feedbackEnable
}

protocol UserDefaultsAccessing {
    func set(_ value: Any?, forKey defaultName: String)

    func bool(forKey defaultName: String) -> Bool
}

extension UserDefaults: UserDefaultsAccessing {}

struct FeedbackEnabledStorage {
    let storage: UserDefaultsAccessing
    let key: DefaultsKey = .feedbackEnable

    init(storage: UserDefaultsAccessing = UserDefaults.standard) {
        self.storage = storage
    }

    func save(value: Bool) {
        storage.set(value, forKey: key.rawValue)
    }

    func load() -> Bool {
        storage.bool(forKey: key.rawValue)
    }
}

private struct FeedbackEnabledStorageKey: EnvironmentKey {
    static let defaultValue: FeedbackEnabledStorage = FeedbackEnabledStorage()
}

extension EnvironmentValues {
    var feedbackStorage: FeedbackEnabledStorage {
        get { self[FeedbackEnabledStorageKey.self] }
        set { self[FeedbackEnabledStorageKey.self] = newValue }
    }
}
