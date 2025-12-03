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
    private let hapticClient = HapticFeedbackClient()

    var body: some View {
        TabView {
            Tab("Tap Tempo", systemImage: "hand.tap.fill") {
                TapTempoView(
                    viewModel: TapTempoViewModel(
                        client: TapTempoClient(),
                        audioPlayer: audioPlayer,
                        hapticClient: hapticClient
                    )
                ).ignoresSafeArea()
            }

            Tab("Metronome", systemImage: "metronome.fill") {
                MetronomeView(
                    viewModel: MetronomeViewModel(
                        client: MetronomeClient(),
                        audioPlayer: audioPlayer,
                        hapticClient: hapticClient
                    )
                ).ignoresSafeArea()
            }

        }
        .overlay(alignment: .topTrailing) {
            helpButton
                .padding(.horizontal, 16)
        }
        .tabViewStyle(.automatic)
        .sheet(isPresented: $isShowingHelp) {
            HelpView {
                isShowingHelp = false
            }
        }
    }

    @ViewBuilder
    private var helpButton: some View {
        if #available(iOS 26.0, *) {
            Button(action: { isShowingHelp.toggle() }) {
                Image(systemName: "questionmark")
                    .font(.system(size: 22))
                    .foregroundColor(.gray)
            }
            .buttonStyle(.glass)
        } else {
            Button(action: { isShowingHelp.toggle() }) {
                Image(systemName: "questionmark.circle")
                    .font(.system(size: 28))
                    .foregroundColor(.white)
            }
            .frame(width: 44, height: 44)
            .buttonStyle(.plain)
        }
    }
}

