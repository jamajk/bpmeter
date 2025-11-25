//
//  TapTempoView.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 25/11/2025.
//

import SwiftUI

struct TapTempoView: View {

    @State private var viewModel = TapTempoViewModel()

    var body: some View {
        ZStack {
            Color.blue

            Text(labelText)
        }
        .onTapGesture { viewModel.onTap() }
    }

    private var labelText: String {
        guard viewModel.roundedBPM != .zero else {
            return "Start tapping" // TODO: Localize
        }
        return String(viewModel.roundedBPM)
    }
}

#Preview {
    TapTempoView()
}
