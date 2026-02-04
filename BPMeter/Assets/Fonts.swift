//
//  Fonts.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 02/12/2025.
//

import SwiftUI

fileprivate enum BPFontName: String {
    case thin = "Lexend-Thin"
    case light = "Lexend-Light"
}

enum BPFont {
    static let lexendThinBody = Font.custom(BPFontName.thin.rawValue, size: 18, relativeTo: .body)
    static let lexendThinLargeTitle = Font.custom(BPFontName.thin.rawValue, size: 38, relativeTo: .largeTitle)

    static let lexendLightFootnote = Font.custom(BPFontName.light.rawValue, size: 12, relativeTo: .footnote)
    static let lexendLightBody = Font.custom(BPFontName.light.rawValue, size: 18, relativeTo: .body)
    static let lexendLightLargeTitle = Font.custom(BPFontName.light.rawValue, size: 38, relativeTo: .largeTitle)
}
