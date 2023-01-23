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
        ZStack(alignment: .top) {
            TempoLabelView(value: 000)
                .padding(.top, 60)
            Color.clear // for tappable space
        }
    }
}
