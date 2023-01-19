//
//  AppView.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 19/01/2023.
//  Copyright © 2023 Jakub Majkowski. All rights reserved.
//

import SwiftUI

struct AppView: View {

    @State var isShowingHelp: Bool = false

    var body: some View {
        FeatureCarouselView(isShowingHelp: $isShowingHelp)
            .sheet(isPresented: $isShowingHelp) {
                HelpView()
            }
    }

}
