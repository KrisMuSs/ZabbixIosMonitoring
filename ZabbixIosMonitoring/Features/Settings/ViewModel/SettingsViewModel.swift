import Foundation
import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    @AppStorage("selected_app_theme") private var storedTheme: String = AppTheme.light.rawValue

    @Published var serverURL: String = "http://192.168.0.72/zabbix/api_jsonrpc.php"
    @Published var login: String = "123"
    @Published var password: String = "••••••••"

    var selectedTheme: AppTheme {
        get { AppTheme(rawValue: storedTheme) ?? .light }
        set { storedTheme = newValue.rawValue }
    }

    var appVersionText: String {
        "Версия 1.0.0"
    }

    func toggleTheme() {
        selectedTheme = selectedTheme == .light ? .dark : .light
    }
}
