//
//  HelpView.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 19/01/2023.
//  Copyright © 2023 Jakub Majkowski. All rights reserved.
//

import SwiftUI

struct HelpView: View {

    @Environment(\.feedbackStorage) var feedbackStorage

    var body: some View {
        ZStack {
            BlurView()
            VStack(spacing: 20) { // TODO: Spacing
                Text("BPMeter")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                ForEach(FeaturePage.allCases, id: \.self) {
                    FeatureExplanationView(feature: $0)
                        .frame(maxWidth: .infinity)
                }

                Toggle(isOn: isHapticFeedbackEnabled) {
                    Text("Vibrations")
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
            .padding(30)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color(uiColor: .lightGray))
                    .opacity(0.75)
            )
            .padding(.horizontal, 16)

        }
        .ignoresSafeArea()
//        .background(Color.indigo) // FIXME: Placeholder
    }

    private var isHapticFeedbackEnabled: Binding<Bool> {
        .init(
            get: { feedbackStorage.load() },
            set: { feedbackStorage.save(value: $0) }
        )
    }

}

private struct FeatureExplanationView: View {

    let feature: FeaturePage

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 12) {
                Text("• \(feature.title):")
                    .font(.headline)
                Text(feature.explanation)
                    .font(.subheadline)
                    .padding(.leading, 20)
            }
            .foregroundColor(.white)

            Spacer()
        }
    }
}

private extension FeaturePage { // TODO: Localize
    var title: String {
        switch self {
        case .tapTempo: return "Tap Tempo Meter"
        case .metronome: return "Metronome"
        }
    }

    var explanation: String {
        switch self {
        case .tapTempo: return "Tap on the screen rhytmically to determine the tempo."
        case .metronome: return "Swipe up/down with two fingers to set the desired tempo, and press the button on the screen to turn the metronome on/off."
        }
    }
}

struct HelpView_Previews: PreviewProvider {

    static var previews: some View {
        HelpView()
            .background(
                VStack(spacing: 0) {
                    Color.blue
                    Color.red
                }.ignoresSafeArea()
            )
    }

}
