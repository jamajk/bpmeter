//
//  TapTempoView.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 25/11/2025.
//

import SwiftUI
import SwiftUIRippleEffect

struct TapTempoView: View {
    @State private var viewModel: TapTempoViewModel

    @State private var rippleOrigin: CGPoint = .zero
    @State private var rippleTrigger: Bool = false

    init(viewModel: TapTempoViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            Rectangle()
                .fill(viewModel.background.backgroundColor.gradient)
                .edgesIgnoringSafeArea(.all)
                .background(
                    GeometryReader { reader in
                        Color.clear
                            .onAppear { viewModel.updateViewportSize(reader.size) }
                            .onChange(of: reader.size) { _, newSize in
                                viewModel.updateViewportSize(newSize)
                            }
                    }
                )
                .rippleEffect(
                    at: rippleOrigin,
                    trigger: rippleTrigger,
                    configuration: .init(
                        duration: 1.5,
                        amplitude: 30,
                        frequency: 12,
                        decay: 12,
                        speed: 1500
                    )
                )

            Circle()
                .fill(Color.red)
                .frame(width: 120)
                .position(x: viewModel.bubbleXPosition, y: viewModel.bubbleYPosition)

            Rectangle()
                .fill(.ultraThinMaterial)
                .edgesIgnoringSafeArea(.all)

            content
        }
        .animation(.easeOut(duration: 0.1), value: viewModel.background)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { gesture in
                    guard gesture.velocity == .zero else { return }
                    rippleOrigin = gesture.location
                    rippleTrigger.toggle()
                    viewModel.onTap()
                }
        )
        .onAppear { viewModel.onAppear() }
        .onDisappear { viewModel.onDisappear() }
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
