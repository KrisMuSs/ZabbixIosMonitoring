//
//  ZabbixIosMonitoringApp.swift
//  ZabbixIosMonitoring
//
//  Created by Артем Мерзликин on 14.04.2026.
//

import SwiftUI

@main
struct ZabbixIosMonitoringApp: App {
    @AppStorage("selected_app_theme") private var storedTheme: String = AppTheme.light.rawValue

    var body: some Scene {
        WindowGroup {
            MainView()
                .preferredColorScheme(currentColorScheme)
        }
    }

    private var currentColorScheme: ColorScheme {
        switch AppTheme(rawValue: storedTheme) ?? .light {
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}
