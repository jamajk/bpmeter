//
//  Knob.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 03/12/2025.
//

import SwiftUI

// TODO: Clean up + add dark mode colors maybe
struct NeomorphicKnob: View {
    @Binding var value: Double // 60 to 240
    var size: CGFloat = 200

    @State private var lastAngle: Double = 0
    @State private var isDragging = false
    @State private var lastHapticValue: Int = 0

    private let hapticFeedback = UIImpactFeedbackGenerator(style: .light)

    // Convert value (60-240) to rotation angle
    // At value 120 (center), rotation should be 0°
    // Each value change = 2 degrees of rotation for easier control
    private var rotationAngle: Double {
        let centerValue = 120.0
        let degreesPerValue = 2.0 // Larger stride for easier selection
        return (value - centerValue) * degreesPerValue
    }

    var body: some View {
        ZStack {
            // Main knob body with neomorphic effect (shadows don't rotate)
            Circle()
                .fill(
                    LinearGradient(
                        colors: [
                            Color(white: 0.88),
                            Color(white: 0.92)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: size, height: size)
                .shadow(color: Color.white.opacity(0.5), radius: 10, x: -8, y: -8)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 8, y: 8)

            // Inner shadow effect (inset) - also doesn't rotate
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color(white: 0.85),
                            Color(white: 0.92)
                        ],
                        center: .center,
                        startRadius: size * 0.3,
                        endRadius: size * 0.5
                    )
                )
                .frame(width: size * 0.9, height: size * 0.9)
                .shadow(color: Color.black.opacity(0.15), radius: 8, x: 4, y: 4)
                .shadow(color: Color.white.opacity(0.4), radius: 8, x: -4, y: -4)

            // Only the indicator dot rotates
            Circle()
                .fill(
                    LinearGradient(
                        colors: [
                            Color(white: 0.75),
                            Color(white: 0.65)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: size * 0.08, height: size * 0.08)
                .shadow(color: Color.black.opacity(0.3), radius: 3, x: 2, y: 2)
                .offset(y: -size * 0.32)
                .rotationEffect(.degrees(rotationAngle))
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { gesture in
                    let center = CGPoint(x: size / 2, y: size / 2)
                    let location = gesture.location

                    // Calculate angle from center to touch point
                    let angle = atan2(location.y - center.y, location.x - center.x)
                    let degrees = angle * 180 / .pi

                    if !isDragging {
                        isDragging = true
                        lastAngle = degrees
                        lastHapticValue = Int(value)
                        hapticFeedback.prepare()
                        return
                    }

                    // Calculate the change in angle
                    var angleDelta = degrees - lastAngle

                    // Handle wraparound at 180°/-180° boundary
                    if angleDelta > 180 {
                        angleDelta -= 360
                    } else if angleDelta < -180 {
                        angleDelta += 360
                    }

                    // Convert angle change to value change
                    // 2 degrees of rotation = 1 value unit for easier control
                    let valueChange = angleDelta / 2.0
                    let newValue = value + valueChange
                    let clampedValue = max(60, min(240, newValue))
                    value = clampedValue

                    // Trigger haptic feedback on integer change
                    let currentIntValue = Int(clampedValue)
                    if currentIntValue != lastHapticValue {
                        hapticFeedback.impactOccurred()
                        lastHapticValue = currentIntValue
                    }

                    lastAngle = degrees
                }
                .onEnded { _ in
                    isDragging = false
                }
        )
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: rotationAngle)
        .onAppear {
            lastHapticValue = Int(value)
            hapticFeedback.prepare()
        }
    }
}

#Preview {
    @Previewable @State var value = 0.5
    NeomorphicKnob(value: $value)
}
