//
//  TapTempoView.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 25/11/2025.
//

import SwiftUI
import SwiftUIRippleEffect

struct TapTempoView: View {
    @State private var viewModel: TapTempoViewModel

    @State private var rippleOrigin: CGPoint = .zero
    @State private var rippleTrigger: Bool = false

    init(viewModel: TapTempoViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            background

            Circle()
                .fill(Color.white.opacity(0.5))
                .frame(width: 120)
                .position(x: viewModel.bubbleXPosition, y: viewModel.bubbleYPosition)

            blurLayer

            content
        }
        .animation(.easeOut(duration: 0.1), value: viewModel.background)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { gesture in
                    guard gesture.velocity == .zero else { return }
                    rippleOrigin = gesture.location
                    rippleTrigger.toggle()
                    viewModel.onTap()
                }
        )
        .onAppear { viewModel.onAppear() }
        .onDisappear { viewModel.onDisappear() }
    }

    private var background: some View {
        Rectangle()
            .fill(viewModel.background.backgroundColor.gradient)
            .edgesIgnoringSafeArea(.all)
            .background(
                GeometryReader { reader in
                    Color.clear // TODO: Bugs out when switching to metronome and back
                        .onAppear { viewModel.updateViewportSize(reader.size) }
                        .onChange(of: reader.size) { _, newSize in
                            viewModel.updateViewportSize(newSize)
                        }
                }
            )
            .rippleEffect(
                at: rippleOrigin,
                trigger: rippleTrigger,
                configuration: .init(
                    duration: 1.5,
                    amplitude: 30,
                    frequency: 12,
                    decay: 12,
                    speed: 1500
                )
            )
    }

    private var content: some View {
        VStack(spacing: 8) {
            Text(labelText)
                .font(viewModel.isBPMDetected ? BPFont.lexendLightLargeTitle : BPFont.lexendThinLargeTitle)
                .contentTransition(.numericText())
                .animation(.default, value: labelText)

            if viewModel.isBPMDetected {
                Text("[beats per minute]")
                    .font(BPFont.lexendLightFootnote)
            }
        }
        .foregroundStyle(.white)
        .animation(.default, value: viewModel.isBPMDetected)
    }

    private var blurLayer: some View {
        Rectangle()
            .fill(.ultraThinMaterial)
            .edgesIgnoringSafeArea(.all)
    }

    private var labelText: String {
        guard viewModel.isBPMDetected else {
            return "start tapping" // TODO: Localize
        }
        return String(viewModel.bpmValue)
    }
}
