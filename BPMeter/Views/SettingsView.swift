//
//  SettingsView.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 03/12/2025.
//

import SwiftUI

struct SettingsView: View {
    @State var viewModel: SettingsViewModel

    var body: some View {
        List {
            Toggle(isOn: $viewModel.isAudioOn) {
                Text("Sounds").font(BPFont.lexendLightBody)
            }

            Toggle(isOn: $viewModel.isHapticFeedbackOn) {
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
