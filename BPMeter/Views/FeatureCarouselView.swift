//
//  FeatureCarouselView.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 25/11/2025.
//

import SwiftUI

struct FeatureCarouselView: View {
    @State var isShowingHelp: Bool = false

    var body: some View {
        TabView {
            Tab("Tap Tempo", systemImage: "tray.and.arrow.down.fill") {
                TapTempoView().ignoresSafeArea()
            }

            Tab("Metronome", systemImage: "tray.and.arrow.down.fill") {
                MetronomeView().ignoresSafeArea()
            }
        }
        .ignoresSafeArea()
        .tabViewStyle(.automatic)
        .background(Color.blue.ignoresSafeArea())
        .overlay(helpButtonOverlay)
        .sheet(isPresented: $isShowingHelp) {
            Text("Help xd")
        }
    }

    private var helpButtonOverlay: some View {
        VStack {
            Spacer()
            Button(action: { isShowingHelp.toggle() }) {
                Image(systemName: "questionmark.circle")
                    .font(.system(size: 28))
                    .foregroundColor(.gray)
                    .padding(24)
            }
//            .frame(width: 44, height: 44)
            .background(Color.clear)
            .buttonStyle(.plain)
            .padding(.bottom, 64)

        }
    }
}

