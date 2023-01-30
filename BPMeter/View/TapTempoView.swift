//
//  TapTempoView.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 23/01/2023.
//  Copyright © 2023 Jakub Majkowski. All rights reserved.
//

import SwiftUI

struct TapTempoView: View {
    var body: some View {
        TapMeasuringView(onTap: { print("TAP IN \($0)") }) {
            ZStack(alignment: .top) {
                Color.blue // for tappable space
                TempoLabelView(value: 000)
                    .padding(.top, 60)
            }
        }
    }
}
