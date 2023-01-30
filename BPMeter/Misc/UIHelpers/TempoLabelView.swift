//
//  TempoLabelView.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 23/01/2023.
//  Copyright © 2023 Jakub Majkowski. All rights reserved.
//

import SwiftUI

struct TempoLabelView: View {
    let value: Int

    var body: some View {
        VStack(spacing: 4) {
            Text(String(value))
                .font(.system(size: 45))
                .fontWeight(.heavy)
                .foregroundColor(.white)
            Text("Tempo")
                .font(.system(size: 14))
                .fontWeight(.medium)
                .foregroundColor(Color(uiColor: .lightGray))
        }
        .animation(.linear(duration: 0.2), value: value)
    }
}
