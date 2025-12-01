//
//  HelpView.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 01/12/2025.
//

import SwiftUI

struct HelpView: View {
    let onClose: () -> Void

    var body: some View {
        NavigationView {
            VStack {
                Text("Help xd")

                NavigationLink(
                    destination: { Text("Lorem ipsum") },
                    label: { Text("Licences") }
                )
            }
            .toolbar {
                Button("Close", action: onClose)
            }
            .padding()
        }
    }
}
