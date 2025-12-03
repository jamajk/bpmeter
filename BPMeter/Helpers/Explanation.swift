//
//  Explanation.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 04/12/2025.
//

struct Explanation {
    let title: String
    let hints: [Hint]
}

struct Hint {
    let text: String
    let imageName: String?

    init(text: String, imageName: String? = nil) {
        self.text = text
        self.imageName = imageName
    }
}
