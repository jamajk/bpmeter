//
//  TapMeasuringView.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 30/01/2023.
//  Copyright © 2023 Jakub Majkowski. All rights reserved.
//

import SwiftUI

struct TapMeasuringView<Content: View>: View {

    let onTap: (CGPoint?) -> Void
    let content: () -> Content

    var body: some View {
        if #available(iOS 16.0, *) {
            content().gesture(
                SpatialTapGesture(count: 1, coordinateSpace: .global)
                    .onEnded { value in
                        onTap(value.location)
                    }
            )
        } else {
            content()
                .onTapGesture { onTap(nil) }
        }
    }
}
