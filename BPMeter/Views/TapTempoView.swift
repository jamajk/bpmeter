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

    init(viewModel: TapTempoViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            background

            FloatingBallsView(viewModel: viewModel.floatingBallsViewModel)

            blurLayer

            content
        }
        .animation(.easeOut(duration: 0.1), value: viewModel.background)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { gesture in
                    guard gesture.velocity == .zero else { return }
                    viewModel.onTap(origin: gesture.location)
                }
        )
    }

    private var background: some View {
        Rectangle()
            .fill(viewModel.background.backgroundColor.gradient)
            .edgesIgnoringSafeArea(.all)
            .rippleEffect(
                at: viewModel.rippleOrigin,
                trigger: viewModel.rippleTrigger,
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
