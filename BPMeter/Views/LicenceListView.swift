//
//  LicenceListView.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 03/12/2025.
//

import SwiftUI

struct LicenceListView: View {
    private let licences: [Licence] = [
        .rippleEffect,
        .fontLexend
    ]

    var body: some View {
        List {
            ForEach(licences, id: \.fileName) { licence in
                NavigationLink(
                    destination: { LicenceDetailsView(licence: licence) },
                    label: { Text(licence.displayName).font(BPFont.lexendLightBody) }
                )
            }
        }
        .toolbar {
            ToolbarItem(placement: .title) {
                Text("credits")
                    .font(BPFont.lexendThinLargeTitle)
            }
        }
    }
}
