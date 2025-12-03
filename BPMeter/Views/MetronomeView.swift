//
//  MetronomeView.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 25/11/2025.
//

import SwiftUI

struct MetronomeView: View {
    @State private var viewModel: MetronomeViewModel

    init(viewModel: MetronomeViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            Rectangle()
                .fill(viewModel.background.backgroundColor.gradient)

            Rectangle()
                .fill(.ultraThinMaterial)

            metronomeContent
        }
        .animation(.easeOut(duration: 0.1), value: viewModel.background)
        .onDisappear {
            viewModel.stopPlaybackIfNeeded() // TODO: Investigate why there is a delay
        }
    }

    private var metronomeContent: some View {
        VStack(spacing: 24) {
            VStack(spacing: 8) {
                Text("\(viewModel.currentBPM)")
                    .font(BPFont.lexendLightLargeTitle)

                Text("[beats per minute]")
                    .font(BPFont.lexendLightFootnote)
                    .padding(.bottom, 16)

                NeomorphicKnob(
                    value: Binding(
                        get: { Double(viewModel.currentBPM) },
                        set: { viewModel.onBPMChanged(to: Int($0)) }
                    )
                )
            }
            .foregroundStyle(.white)

            HStack {
                Text("Beats: \(viewModel.currentBeatsPerMeasure)")
                Stepper(
                    "",
                    value: Binding(
                        get: { viewModel.currentBeatsPerMeasure },
                        set: { viewModel.onBeatsPerMeasureChanged(to: $0) }
                    ),
                    in: 1...12
                )
            }

            Button(action: { viewModel.onStartStopTapped() }) {
                viewModel.buttonState.icon
                    .resizable()
                    .frame(width: 44, height: 44)
                    .foregroundStyle(viewModel.buttonState.backgroundColor)
                    .shadow(color: viewModel.buttonState.backgroundColor, radius: 10)
            }
        }
        .padding()
    }
}

private extension StartButtonState {
    var icon: Image {
        Image(systemName: "power.circle")
    }

    var backgroundColor: Color {
        switch self {
        case .start: .white
        case .stop: .green
        }
    }
} 
