//
//  HelpView.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 01/12/2025.
//

import SwiftUI

struct HelpView: View {
    let onClose: () -> Void

    var body: some View {
        NavigationView {
            List {
                Color.gray
                    .frame(height: 200)
                    .overlay(Text("How to tap tempo"))

                Color.gray
                    .frame(height: 200)
                    .overlay(Text("How to metronome"))

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
        }
    }

    private var divider: some View {
        Divider().padding(.vertical, 8)
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
