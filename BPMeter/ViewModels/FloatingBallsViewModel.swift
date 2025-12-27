//
//  FloatingBallsViewModel.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 08/12/2025.
//

import SwiftUI
import SpriteKit

@Observable
class FloatingBallsViewModel {
    var scene: BallScene?

    func handleTap(at location: CGPoint) {
        // Convert SwiftUI coordinates (top-left origin) to SpriteKit coordinates (bottom-left origin)
        guard let scene = scene else { return }
        let spriteKitLocation = CGPoint(x: location.x, y: scene.size.height - location.y)
        scene.handleExternalTap(at: spriteKitLocation)
    }
}
