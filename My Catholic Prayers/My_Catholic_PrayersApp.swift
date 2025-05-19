//
//  My_Catholic_PrayersApp.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/4/25.
//

import SwiftUI

@main
struct My_Catholic_PrayersApp: App {
    @StateObject private var settings = AppSettings.shared  // ✅ Declare it here

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(settings)  // ✅ Pass to views if needed
                .preferredColorScheme(settings.colorScheme)  // ✅ Respect theme setting
        }
    }
}
