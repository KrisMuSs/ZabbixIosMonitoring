import Foundation

struct DashboardSummary {
    let onlineCount: Int
    let problemsCount: Int
    let offlineCount: Int
}

struct DashboardCPUHost: Identifiable {
    let id: String
    let name: String
    let cpuLoad: Int
}

struct DashboardRecentProblem: Identifiable {
    let id: String
    let title: String
    let hostName: String
    let timeText: String
    let severity: ProblemSeverityLevel
}

struct DashboardModel {
    let summary: DashboardSummary
    let topCPUHosts: [DashboardCPUHost]
    let recentProblems: [DashboardRecentProblem]
}
