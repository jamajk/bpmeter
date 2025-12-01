//
//  FeatureCarouselView.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 25/11/2025.
//

import SwiftUI

struct FeatureCarouselView: View {
    @State var isShowingHelp: Bool = false

    private let audioPlayer = AudioPlayerClient() // separation of concerns is calling... maybe split initing viewmodels to viewmodel

    var body: some View {
        TabView {
            Tab("Tap Tempo", systemImage: "hand.tap.fill") {
                TapTempoView(
                    viewModel: TapTempoViewModel(
                        client: TapTempoClient(),
                        audioPlayer: audioPlayer
                    )
                ).ignoresSafeArea()
            }

            Tab("Metronome", systemImage: "metronome.fill") {
                MetronomeView(
                    viewModel: MetronomeViewModel(
                        client: MetronomeClient(),
                        audioPlayer: audioPlayer
                    )
                ).ignoresSafeArea()
            }
        }
        .ignoresSafeArea()
        .tabViewStyle(.automatic)
        .overlay(helpButtonOverlay)
        .sheet(isPresented: $isShowingHelp) {
            HelpView {
                isShowingHelp = false
            }
        }
    }

    private var helpButtonOverlay: some View {
        VStack {
            Spacer()
            helpButton
                .padding(.bottom, 64)
        }
    }

    private var helpButton: some View {
        Button(action: { isShowingHelp.toggle() }) {
            Image(systemName: "questionmark.circle")
                .font(.system(size: 28))
                .foregroundColor(.white)
                .padding(24)
        }
        .buttonStyle(.plain)
    }
}

