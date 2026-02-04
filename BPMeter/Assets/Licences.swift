//
//  Licences.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 03/12/2025.
//

enum Licence {
    case rippleEffect
    case fontLexend

    var displayName: String { fileName }

    var fileName: String {
        switch self {
        case .rippleEffect: "SwiftUIRippleEffect"
        case .fontLexend: "Lexend"
        }
    }
}
