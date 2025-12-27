//
//  HelpView.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 01/12/2025.
//

import SwiftUI

struct HelpView: View {
    let onClose: () -> Void

    @Environment(StorageClient.self) private var storageClient

    private let explanations: [Explanation] = [
        Explanation(
            title: "Tap tempo",
            hints: [
                Hint(text: "Tap on the screen rhytmically to determine the tempo.")
            ]
        ),
        Explanation(
            title: "Metronome",
            hints: [
                Hint(text: "Rotate the knob to select the desired tempo.", imageName: "arrow.trianglehead.2.clockwise.rotate.90"),
//                Hint(text: "Select how many beats should count as one measure. [todo]", imageName: "plus.forwardslash.minus"),
                Hint(text: "Press the button below to turn the metronome on/off.", imageName: "power.circle")
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
                    destination: { SettingsView(viewModel: SettingsViewModel(storageClient: storageClient)) }, // TODO: Fix initing this VM
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
