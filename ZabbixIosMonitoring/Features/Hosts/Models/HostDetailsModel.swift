import Foundation

struct HostDetailsModel: Identifiable {
    let id: String
    let name: String
    let ipAddress: String
    let status: HostStatus

    let cpuLoad: Int
    let ramLoad: Int
    let diskLoad: Int

    let cpuHistory: [MetricPoint]
    let ramHistory: [MetricPoint]
    let diskHistory: [MetricPoint]

    let activeProblems: [HostProblem]
}

struct MetricPoint: Identifiable {
    let id = UUID()
    let hour: String
    let value: Double
}

struct HostProblem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let severity: ProblemSeverity
}

enum ProblemSeverity {
    case warning
    case critical
}
