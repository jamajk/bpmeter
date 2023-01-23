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
        Text(String(value))
            .font(.system(size: 45))
            .fontWeight(.heavy)
            .foregroundColor(.white)
    }
}
