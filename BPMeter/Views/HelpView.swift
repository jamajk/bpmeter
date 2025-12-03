//
//  HelpView.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 01/12/2025.
//

import SwiftUI

struct HelpView: View {
    let onClose: () -> Void

    private let explanations: [Explanation] = [
        Explanation(
            title: "Tap tempo",
            tips: [
                "Tap on the screen rhytmically to determine the tempo."
            ]
        ),
        Explanation(
            title: "Metronome",
            tips: [
                "TODO."
            ]
        )
    ]

    var body: some View {
        NavigationView {
            List {
                ForEach(explanations, id: \.title) { explanation in
                    ExplanationView(explanation: explanation)
                        .padding(.vertical, 8)
                }

                NavigationLink(
                    destination: { SettingsView() },
                    label: { Text("Settings").font(BPFont.lexendLightBody) }
                )

                NavigationLink(
                    destination: { LicenceListView() },
                    label: { Text("Software credits").font(BPFont.lexendLightBody) }
                )
            }
            .listStyle(.inset)
            .toolbar {
                ToolbarItem(placement: .title) {
                    Text("how to")
                        .font(BPFont.lexendThinLargeTitle)
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button(action: onClose) {
                        Image(systemName: "xmark")
                    }
                }
            }
            .tint(.primary)
        }
    }

    private var divider: some View {
        Divider().padding(.vertical, 8)
    }
}

struct Explanation {
    let title: String
    let tips: [String]
}

struct ExplanationView: View {
    let explanation: Explanation

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("\(explanation.title):")
                .font(BPFont.lexendLightBody)

            ForEach(explanation.tips, id: \.self) { tip in
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text("·")

                    Text(tip)
                }
                .font(BPFont.lexendLightFootnote)
                .padding(.leading, 16)
            }
        }
    }
}

struct LicenceListView: View {
    var body: some View {
        List {
            NavigationLink(
                destination: { Text("Lorem ipsum") },
                label: { Text("SwiftUIRippleEffect").font(BPFont.lexendLightBody) }
            )

            NavigationLink(
                destination: { Text("Lorem ipsum") },
                label: { Text("Lexend").font(BPFont.lexendLightBody) }
            )
        }
        .toolbar {
            ToolbarItem(placement: .title) {
                Text("credits")
                    .font(BPFont.lexendThinLargeTitle)
            }
        }
    }
}

struct SettingsView: View {
    @State var isSoundOn: Bool = true // TODO: Placeholder
    @State var isHapticFeedbackOn: Bool = true // TODO: Placeholder
    var body: some View {
        List {
            Toggle(isOn: $isSoundOn) {
                Text("Sounds").font(BPFont.lexendLightBody)
            }

            Toggle(isOn: $isHapticFeedbackOn) {
                Text("Haptic feedback").font(BPFont.lexendLightBody)
            }
        }
        .toolbar {
            ToolbarItem(placement: .title) {
                Text("settings")
                    .font(BPFont.lexendThinLargeTitle)
            }
        }
    }
}
