//
//  Color+Extension.swift
//  Stickit
//
//  Created by Maisie Ng on 4/23/26.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex >> 16) & 0xFF) / 255
        let green = Double((hex >> 8) & 0xFF) / 255
        let blue = Double(hex & 0xFF) / 255
        self.init(red: red, green: green, blue: blue, opacity: opacity)
    }
}


enum NotePalette: Int, CaseIterable, Identifiable {
    case ashGray     = 0xF0EFEB
    case warmBeige   = 0xFFF1E6
    case dustyRose   = 0xFDE2E4
    case sageGreen   = 0xD1E6D3
    case skyBlue     = 0xBEE1E6
    case blushClay   = 0xF3D9DC
    case mistGray    = 0xE2ECE9
    case lavender    = 0xF1DDFF
    case softIndigo  = 0xDFE7FD
    
    var id: Int { rawValue }
}

extension NotePalette {
    
    var color: Color {
        Color(hex: rawValue)
    }
    
    var name: String {
        switch self {
        case .ashGray: return "Ash Gray"
        case .warmBeige: return "Warm Beige"
        case .dustyRose: return "Dusty Rose"
        case .sageGreen: return "Sage Green"
        case .skyBlue: return "Sky Blue"
        case .blushClay: return "Blush Clay"
        case .mistGray: return "Mist Gray"
        case .lavender: return "Lavender"
        case .softIndigo: return "Soft Indigo"
        }
    }
}
