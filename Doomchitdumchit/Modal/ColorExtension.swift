//
//  ColorExtension.swift
//  Doomchitdumchit
//
//  Created by NANA on 4/18/24.
//

// ColorExtentsion.swift
 
import SwiftUI
 
extension Color {
  init(hex: String) {
    let scanner = Scanner(string: hex)
    _ = scanner.scanString("#")
    
    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)
    
    let r = Double((rgb >> 16) & 0xFF) / 255.0
    let g = Double((rgb >>  8) & 0xFF) / 255.0
    let b = Double((rgb >>  0) & 0xFF) / 255.0
    self.init(red: r, green: g, blue: b)
  }
}

extension Color {
 
    static let color1 = Color(hex: "#FFF4EE")
    static let color2 = Color(hex: "#FFEEEE")
    static let color3 = Color(hex: "#FFFEEE")
    static let color4 = Color(hex: "#F0FFEE")
    static let color5 = Color(hex: "#EEFEFF")
    static let color6 = Color(hex: "#EEF6FF")
    static let color7 = Color(hex: "#F3EEFF")
    static let color8 = Color(hex: "#FFEEFC")
}
