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
                Text("BPM: \(viewModel.bpm)")
                Slider(value: Binding(
                    get: { Double(viewModel.bpm) },
                    set: { viewModel.bpm = Int($0) }
                ), in: 30...240)
            }

            HStack {
                Text("Beats: \(viewModel.beatsPerMeasure)")
                Stepper("", value: $viewModel.beatsPerMeasure, in: 1...12)
            }

            Button(viewModel.isRunning ? "Stop" : "Start") {
                viewModel.onTapStartStop()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(viewModel.isRunning ? .red : .green)
            .foregroundColor(.white)
            .cornerRadius(12)
        }
        .padding()
    }
}
