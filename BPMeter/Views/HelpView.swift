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
