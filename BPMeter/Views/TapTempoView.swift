//
//  TapTempoView.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 25/11/2025.
//

import SwiftUI

struct TapTempoView: View {
    @State private var viewModel: TapTempoViewModel
    @State private var bubbleYPosition: CGFloat = 600

    init(viewModel: TapTempoViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            Rectangle()
                .fill(viewModel.background.backgroundColor.gradient)
                .edgesIgnoringSafeArea(.all)

            Circle()
                .fill(Color.red)
                .frame(width: 120)
                .position(y: bubbleYPosition)

            Rectangle()
                .fill(.ultraThinMaterial)
                .edgesIgnoringSafeArea(.all)

            content
        }
        .animation(.easeOut(duration: 0.1), value: viewModel.background)
        .onTapGesture { origin in
            viewModel.onTap()
        }
        .onLongPressGesture(minimumDuration: 0) {
            viewModel.onTap()
        }
        .onAppear {
            withAnimation(.linear(duration: 7)) {
                bubbleYPosition = 0
            }
        }
    }

    private var content: some View {
        Text(labelText)
            .font(.largeTitle)
            .bold()
            .foregroundStyle(.white)
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
