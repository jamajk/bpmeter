//
//  HapticFeedbackClient.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 03/12/2025.
//

import UIKit

protocol HapticFeedbackClientProtocol {
    func vibrate()
}

struct HapticFeedbackClient: HapticFeedbackClientProtocol {
    private let generator = UIImpactFeedbackGenerator(style: .light)

    func vibrate() {
        generator.impactOccurred()
    }
}
