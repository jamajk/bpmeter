//
//  StorageClient.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 08/12/2025.
//

import Foundation
import SwiftUI

protocol StorageClientProtocol: AnyObject {
    func readValue(for key: StorageKeys) -> Bool
    func setValue(_ newValue: Bool, for key: StorageKeys)
}

@Observable
class StorageClient: StorageClientProtocol {
    private let defaults: UserDefaults

    init(defaults: UserDefaults = UserDefaults.standard) {
        self.defaults = defaults
    }

    func readValue(for key: StorageKeys) -> Bool {
        defaults.bool(forKey: key.rawValue)
    }

    func setValue(_ newValue: Bool, for key: StorageKeys) {
        defaults.set(newValue, forKey: key.rawValue)
    }
}


