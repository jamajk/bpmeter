//
//  MetronomeView.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 25/11/2025.
//

import SwiftUI

struct MetronomeView: View {
    @State private var viewModel = MetronomeViewModel()

    var body: some View {
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

extension StartButtonState {
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
