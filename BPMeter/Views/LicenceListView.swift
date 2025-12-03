//
//  LicenceListView.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 03/12/2025.
//

import SwiftUI

struct LicenceListView: View {
    var body: some View {
        List {
            NavigationLink(
                destination: { Text("Lorem ipsum") },
                label: { Text("SwiftUIRippleEffect").font(BPFont.lexendLightBody) }
            )

            NavigationLink(
                destination: { Text("Lorem ipsum") },
                label: { Text("Lexend").font(BPFont.lexendLightBody) }
            )
        }
        .toolbar {
            ToolbarItem(placement: .title) {
                Text("credits")
                    .font(BPFont.lexendThinLargeTitle)
            }
        }
    }
}
