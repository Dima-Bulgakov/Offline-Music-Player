//
//  Color+Extension.swift
//  MusicApp23
//
//  Created by Dima on 21.12.2023.
//

import SwiftUI

// MARK: - Color Extension
extension Color {
    static func hexToColor(hex: String) -> Color {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0

        return Color(red: red, green: green, blue: blue)
    }
    
    static let bg = Color.hexToColor(hex: "080705")
    static let accent = Color.hexToColor(hex: "3C93F8")
    static let primaryFont = Color.hexToColor(hex: "F5F5F5")
    static let secondaryFont = Color.hexToColor(hex: "B5B5B4")
    static let selectedPlaylistBG = Color.hexToColor(hex: "FAF8FE")
    static let unSelectedPlaylistBG = Color.hexToColor(hex: "0A0C10")
    static let timeline = Color.hexToColor(hex: "1C1B19")
    static let bunner = Color.hexToColor(hex: "0A0D10")
    static let menu = Color.hexToColor(hex: "#0F1317")
}
