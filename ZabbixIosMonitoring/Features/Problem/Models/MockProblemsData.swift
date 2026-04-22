import Foundation

enum MockProblemsData {
    static let problems: [ProblemModel] = [
        ProblemModel(
            id: "1",
            title: "Service unavailable",
            hostName: "app-server-02",
            timeText: "1 час назад",
            severity: .critical,
            status: .active
        ),
        ProblemModel(
            id: "2",
            title: "Memory usage high",
            hostName: "db-master",
            timeText: "3 часа назад",
            severity: .high,
            status: .active
        ),
        ProblemModel(
            id: "3",
            title: "SSL certificate expiring",
            hostName: "web-server-01",
            timeText: "5 часов назад",
            severity: .warning,
            status: .active
        ),
        ProblemModel(
            id: "4",
            title: "Network latency",
            hostName: "mail-server",
            timeText: "1 день назад",
            severity: .info,
            status: .resolved
        ),
        ProblemModel(
            id: "5",
            title: "CPU usage high",
            hostName: "api-gateway",
            timeText: "2 мин назад",
            severity: .critical,
            status: .active
        ),
        ProblemModel(
            id: "6",
            title: "Disk space low",
            hostName: "backup-node",
            timeText: "40 мин назад",
            severity: .high,
            status: .resolved
        )
    ]
}
