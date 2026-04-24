import Foundation

@MainActor
final class DashboardViewModel: ObservableObject {
    @Published var dashboard: DashboardModel?
    @Published var isLoading = false

    func load() async {
        isLoading = true
        try? await Task.sleep(nanoseconds: 300_000_000)
        dashboard = MockDashboardData.dashboard
        isLoading = false
    }
}
