//
//  AppSettings.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/6/25.
//

import SwiftUI

class AppSettings: ObservableObject {
    static let shared = AppSettings()
    
    @AppStorage("selectedAppearance") var selectedAppearance: String = "system"
    @AppStorage("useLatin") var useLatin: Bool = false
    @AppStorage("selectedVoiceIdentifier") var selectedVoiceIdentifier: String = ""
    @AppStorage("rosaryAutoPlay") var rosaryAutoPlay: Bool = false

    var colorScheme: ColorScheme? {
        switch selectedAppearance {
        case "light": return .light
        case "dark": return .dark
        default: return nil
        }
    }
}
