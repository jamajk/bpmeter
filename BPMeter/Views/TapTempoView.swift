//
//  TapTempoView.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 25/11/2025.
//

import SwiftUI

struct TapTempoView: View {
    @State private var viewModel: TapTempoViewModel

    init(viewModel: TapTempoViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            Color.blue

            Text(labelText)
        }
//        .onTapGesture { origin in
//            viewModel.onTap()
//        }
        .onLongPressGesture(minimumDuration: 0) {
            print("Touch Down")
            viewModel.onTap()
        }
    }

    private var labelText: String {
        guard viewModel.bpmValue != .zero else {
            return "Start tapping" // TODO: Localize
        }
        return String(viewModel.bpmValue)
    }
}

//#Preview {
//    TapTempoView() // TODO: need an audio player mock
//}
