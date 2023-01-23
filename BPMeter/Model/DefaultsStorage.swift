//
//  DefaultsStorage.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 23/01/2023.
//  Copyright © 2023 Jakub Majkowski. All rights reserved.
//

import Foundation

enum DefaultsKey: String {
    case feedbackEnable
}

struct FeedbackEnabledStorage {
    let storage = UserDefaults.standard
    let key: DefaultsKey = .feedbackEnable

    func save(value: Bool) {
        storage.set(value, forKey: key.rawValue)
    }

    func load() -> Bool? {
        storage.bool(forKey: key.rawValue)
    }
}
