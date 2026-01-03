//
//  NeomorphicToggle.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 27/12/2025.
//

import SwiftUI

struct NeomorphicToggle: View {
    var buttonState: StartButtonState
    var width: CGFloat = 100
    var height: CGFloat = 100
    var onToggleAction: () -> Void

    @State private var isPressed = false
    private let hapticFeedback = UIImpactFeedbackGenerator(style: .medium)

    private var cornerRadius: CGFloat {
        min(width, height) / 5
    }

    private var isOnState: Bool {
        buttonState == .stop
    }

    var body: some View {
        ZStack {
            // Green glow effect
            RoundedRectangle(cornerRadius: cornerRadius * 0.75)
                .fill(
                    RadialGradient(
                        colors: [
                            Color.green.opacity(0.4),
                            Color.green.opacity(0.15),
                            Color.green.opacity(0.0)
                        ],
                        center: .center,
                        startRadius: 0,
                        endRadius: min(width, height) * 0.3
                    )
                )
                .frame(width: width * 0.7, height: height * 0.6)
                .blur(radius: 6)

            RoundedRectangle(cornerRadius: cornerRadius * 0.75)
                .fill(
                    LinearGradient(
                        colors: [
                            isOnState ? Color(white: 0.78) : Color(white: 0.92),
                            isOnState ? Color(white: 0.82) : Color(white: 0.88)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: width * 0.7, height: height * 0.6)
                .overlay(
                    // Power icon
                    Image(systemName: "power")
                        .font(.system(size: min(width, height) * 0.3, weight: .semibold))
                        .foregroundStyle(isOnState ? .green.opacity(0.7) : .gray.opacity(0.5))
                )
        }
        .scaleEffect(isOnState ? 0.98 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isOnState)
        .frame(width: width, height: height)
        .onTapGesture {
            onToggleAction()
        }
    }
}
