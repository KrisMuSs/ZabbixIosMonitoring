import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    @Published var serverURL: String = "http://192.168.0.72/zabbix/api_jsonrpc.php"
    @Published var login: String = "123"
    @Published var password: String = "••••••••"

    var appVersionText: String {
        "Версия 1.0.0"
    }
}
