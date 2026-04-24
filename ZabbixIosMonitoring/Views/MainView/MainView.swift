import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("Дашборд")
                }

            HostsListView()
                .tabItem {
                    Image(systemName: "server.rack")
                    Text("Хосты")
                }

            ProblemsListView()
                .tabItem {
                    Image(systemName: "exclamationmark.triangle")
                    Text("Проблемы")
                }

            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Настройки")
                }
        }
    }
}

#Preview {
    MainView()
}
