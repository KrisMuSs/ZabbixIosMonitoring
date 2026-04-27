import SwiftUI

struct MainView: View {
    @AppStorage("selected_app_theme") private var storedTheme: String = AppTheme.light.rawValue
    @State private var selectedTab: AppTab = .dashboard

    var body: some View {
        TabView(selection: $selectedTab) {
            DashboardView()
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("Дашборд")
                }
                .tag(AppTab.dashboard)

            HostsListView()
                .tabItem {
                    Image(systemName: "server.rack")
                    Text("Хосты")
                }
                .tag(AppTab.hosts)

            ProblemsListView()
                .tabItem {
                    Image(systemName: "exclamationmark.triangle")
                    Text("Проблемы")
                }
                .tag(AppTab.problems)

            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Настройки")
                }
                .tag(AppTab.settings)
        }
        .preferredColorScheme(currentColorScheme)
        .id(storedTheme)
    }

    private var currentColorScheme: ColorScheme {
        let theme = AppTheme(rawValue: storedTheme) ?? .light

        switch theme {
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}

private enum AppTab {
    case dashboard
    case hosts
    case problems
    case settings
}

#Preview {
    MainView()
}
