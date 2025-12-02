//
//  HapticFeedbackClient.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 03/12/2025.
//

import UIKit

struct HapticFeedbackClient {
    private let generator = UIImpactFeedbackGenerator(style: .light)

    func vibrate() {
        generator.impactOccurred()
    }
}
