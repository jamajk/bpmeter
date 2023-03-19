//
//  MetronomeView.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 19/03/2023.
//  Copyright © 2023 Jakub Majkowski. All rights reserved.
//

import SwiftUI

struct MetronomeView: View {

    @State var desiredTempo: Int = 120
    @State var rotationAngle: Double = 0
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.blue // for tappable space
            TempoLabelView(value: desiredTempo)
                .padding(.top, 60)

            VStack {
                Spacer()

                ZStack(alignment: .top) {
                    Circle()
                        .fill(Color.gray)

                    Circle()
                        .fill(Color.red)
                        .frame(width: 8, height: 8)
                        .padding(.top, 8)
                }
                    .frame(width: 250, height: 250)
                    .rotationEffect(.init(degrees: rotationAngle))
                    .gesture(
                        RotationGesture()
                            .onChanged {
                                print("Rotation \($0.degrees)")
                                rotationAngle = $0.degrees
                            }
                            .onEnded {
                                print("Rotation ended \($0.degrees)")
                                rotationAngle = $0.degrees
                            }
                    )

                Spacer()
            }
        }

    }
}
