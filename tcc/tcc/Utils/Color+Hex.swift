import SwiftUI

extension Color {
    /// Initialize a Color from a hex string.
    /// Supports formats: RRGGBB, AARRGGBB, with or without leading '#', and optional whitespace.
    /// Examples: "#FF0000", "FF0000", "80FF0000" (alpha first)
    init(hex: String) {
        let hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
        var hexNumber: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&hexNumber)

        let r, g, b, a: Double
        switch hexString.count {
        case 6:
            r = Double((hexNumber & 0xFF0000) >> 16) / 255.0
            g = Double((hexNumber & 0x00FF00) >> 8) / 255.0
            b = Double(hexNumber & 0x0000FF) / 255.0
            a = 1.0
        case 8:
            // Interpret as AARRGGBB
            a = Double((hexNumber & 0xFF000000) >> 24) / 255.0
            r = Double((hexNumber & 0x00FF0000) >> 16) / 255.0
            g = Double((hexNumber & 0x0000FF00) >> 8) / 255.0
            b = Double(hexNumber & 0x000000FF) / 255.0
        default:
            // Fallback to clear color for invalid input
            r = 0; g = 0; b = 0; a = 0
        }

        self.init(.sRGB, red: r, green: g, blue: b, opacity: a)
    }

    /// Alias supporting a different param name some code might use (`hexa`).
    init(hexa: String) {
        self.init(hex: hexa)
    }
}
