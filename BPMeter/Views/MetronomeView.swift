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
            viewModel.background.backgroundColor

            metronomeContent
        }
        .animation(.easeOut(duration: 0.1), value: viewModel.background)
        .onDisappear {
            viewModel.stopPlaybackIfNeeded() // TODO: Investigate why there is a delay
        }
    }

    private var metronomeContent: some View {
        VStack(spacing: 24) {
            Text("Metronome")
                .font(.largeTitle)

            HStack {
                Text("BPM: \(viewModel.currentBPM)")
                Slider(
                    value: Binding(
                        get: { Double(viewModel.currentBPM) },
                        set: { viewModel.onBPMChanged(to: Int($0)) }
                    ),
                    in: 30...240
                )
            }

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

            Button(viewModel.buttonState.title) {
                viewModel.onStartStopTapped()
            }
            .padding()
            .background(viewModel.buttonState.backgroundColor)
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .cornerRadius(12)
        }
        .padding()
    }
}

private extension StartButtonState {
    var title: String {
        switch self {
        case .start: "Start"
        case .stop: "Stop"
        }
    }

    var backgroundColor: Color {
        switch self {
        case .start: .green
        case .stop: .red
        }
    }
} 
