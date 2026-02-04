//
//  LicenceDetailsView.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 03/12/2025.
//

import SwiftUI

struct LicenceDetailsView: View {
    @State private var textFile = ""

    let licence: Licence

    var body: some View {
        ScrollView {
            Text(textFile)
                .padding()
        }
        .onAppear { readTextFile() }
    }

    func readTextFile() {
        if let textFileUrl = Bundle.main.url(forResource: licence.fileName, withExtension: "txt") {
            if let contents = try? String(contentsOf: textFileUrl, encoding: .utf8) {
                textFile = contents
            }
        }
    }
}
