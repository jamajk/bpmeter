//
//  TapTempoView.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 23/01/2023.
//  Copyright © 2023 Jakub Majkowski. All rights reserved.
//

import SwiftUI

struct TapTempoView: View {

    @StateObject var counter = Counter()

    var body: some View {
        TapMeasuringView(
            onTap: {
                print("TAP IN \($0)")
                counter.onTap()
            }
        ) {
            ZStack(alignment: .top) {
                Color.blue // for tappable space
                TempoLabelView(value: Int(counter.tempo))
                    .padding(.top, 60)
            }
        }
    }
}
