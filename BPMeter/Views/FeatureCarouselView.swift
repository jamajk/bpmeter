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
            Tab("Tap Tempo", systemImage: "tray.and.arrow.down.fill") {
                TapTempoView(
                    viewModel: TapTempoViewModel(
                        client: TapTempoClient(),
                        audioPlayer: audioPlayer
                    )
                ).ignoresSafeArea()
            }

            Tab("Metronome", systemImage: "tray.and.arrow.down.fill") {
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
        .background(Color.blue.ignoresSafeArea())
        .overlay(helpButtonOverlay)
        .sheet(isPresented: $isShowingHelp) {
            Text("Help xd")
                .toolbar {
                    Button("Close", action: { isShowingHelp = false })
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
                .foregroundColor(.gray)
                .padding(24)
        }
//            .frame(width: 44, height: 44)
        .buttonStyle(.plain)
    }
}

