//
//  SettingsView.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 03/12/2025.
//

import SwiftUI

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
