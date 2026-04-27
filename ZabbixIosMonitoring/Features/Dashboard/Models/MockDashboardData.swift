import Foundation

enum MockDashboardData {
    static let dashboard = DashboardModel(
        summary: DashboardSummary(
            onlineCount: 5,
            problemsCount: 2,
            offlineCount: 1
        ),
        topCPUHosts: [
            DashboardCPUHost(id: "1", name: "Web Server", cpuLoad: 92),
            DashboardCPUHost(id: "2", name: "DB Server", cpuLoad: 78),
            DashboardCPUHost(id: "3", name: "Mail Server", cpuLoad: 67),
            DashboardCPUHost(id: "4", name: "File Server", cpuLoad: 45),
            DashboardCPUHost(id: "5", name: "Backup Server", cpuLoad: 34)
        ],
        recentProblems: [
            DashboardRecentProblem(
                id: "1",
                title: "High CPU usage",
                hostName: "api-gateway",
                timeText: "2 мин назад",
                severity: .critical
            ),
            DashboardRecentProblem(
                id: "2",
                title: "Disk space low",
                hostName: "backup-storage",
                timeText: "15 мин назад",
                severity: .high
            ),
            DashboardRecentProblem(
                id: "3",
                title: "Service unavailable",
                hostName: "app-server-02",
                timeText: "1 час назад",
                severity: .critical
            ),
            DashboardRecentProblem(
                id: "4",
                title: "Memory usage high",
                hostName: "db-master",
                timeText: "3 часа назад",
                severity: .high
            )
        ]
    )
}
