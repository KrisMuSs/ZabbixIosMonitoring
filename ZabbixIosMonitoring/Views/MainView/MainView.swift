import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            Text("Дашборд")
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

            Text("Настройки")
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
