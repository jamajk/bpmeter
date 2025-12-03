//
//  ExplanationView.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 03/12/2025.
//

import SwiftUI

struct ExplanationView: View {
    let explanation: Explanation

    var body: some View { // TODO: Font sizes
        VStack(alignment: .leading, spacing: 16) {
            Text("\(explanation.title):")
                .font(BPFont.lexendLightBody)

            ForEach(explanation.hints, id: \.text) { tip in
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text("·")

                    if let imageName = tip.imageName {
                        Text("\(tip.text) \(Image(systemName: imageName))")
                    } else {
                        Text(tip.text)
                    }
                }
                .font(BPFont.lexendLightFootnote)
                .padding(.leading, 16)
            }
        }
    }
}
