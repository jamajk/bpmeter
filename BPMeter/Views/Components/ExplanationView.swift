//
//  ExplanationView.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 03/12/2025.
//

import SwiftUI

struct Explanation {
    let title: String
    let tips: [String]
}

struct ExplanationView: View {
    let explanation: Explanation

    var body: some View { // TODO: Font sizes
        VStack(alignment: .leading, spacing: 16) {
            Text("\(explanation.title):")
                .font(BPFont.lexendLightBody)

            ForEach(explanation.tips, id: \.self) { tip in
                HStack(alignment: .firstTextBaseline, spacing: 8) {
                    Text("·")

                    Text(tip)
                }
                .font(BPFont.lexendLightFootnote)
                .padding(.leading, 16)
            }
        }
    }
}
