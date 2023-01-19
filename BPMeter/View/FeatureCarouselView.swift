//
//  FeatureCarouselView.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 19/01/2023.
//  Copyright © 2023 Jakub Majkowski. All rights reserved.
//

import SwiftUI

struct FeatureCarouselView: View {

    @Binding var isShowingHelp: Bool

    @State var selection: FeaturePage = .tapTempo

    var body: some View {
        TabView(selection: $selection) {
            ForEach(FeaturePage.allCases, id: \.self) { _ in
                Color.green
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .background(Color.blue.ignoresSafeArea())
        .overlay(
            VStack {
                Spacer()
                Button(action: { isShowingHelp.toggle() }) {
                    Image(systemName: "questionmark.circle")
                        .font(.system(size: 28))
                        .foregroundColor(.gray)
                }
                .buttonStyle(.plain)
                .padding(.bottom, 64)

            }
        )
    }
}

enum FeaturePage: String, CaseIterable {
    case tapTempo
    case metronome
}

//struct FeatureCarousel_Previews: PreviewProvider {
//    static var previews: some View {
//        FeatureCarouselView()
//    }
//}
