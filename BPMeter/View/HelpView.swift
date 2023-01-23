//
//  HelpView.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 19/01/2023.
//  Copyright © 2023 Jakub Majkowski. All rights reserved.
//

import SwiftUI

struct HelpView: View {

    var body: some View {
        ZStack {
            BlurView()
            Text("BPMeter")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .ignoresSafeArea()
        .background(Color.indigo) // FIXME: Placeholder
    }

}

struct HelpView_Previews: PreviewProvider {

    static var previews: some View {
        HelpView()
            .background(
                VStack(spacing: 0) {
                    Color.blue
                    Color.red
                }.ignoresSafeArea()
            )
    }

}
