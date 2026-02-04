//
//  BackgroundState+UI.swift
//  BPMeter
//
//  Created by Jakub Majkowski on 01/12/2025.
//

import SwiftUI

extension BackgroundState {
    var backgroundColor: Color {
        switch self {
        case .normal: .blue
        case .tickActive: .teal
        }
    }
}
