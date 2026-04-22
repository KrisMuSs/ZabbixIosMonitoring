import Foundation

enum MockHostCardData {
    static let hosts: [HostCardModel] = [
        HostCardModel(
            id: "1",
            name: "web-server-01",
            ipAddress: "192.168.0.10",
            status: .online,
            cpuLoad: 45,
            ramLoad: 68,
            diskLoad: 72
        ),
        HostCardModel(
            id: "2",
            name: "db-master",
            ipAddress: "192.168.0.20",
            status: .online,
            cpuLoad: 78,
            ramLoad: 85,
            diskLoad: 54
        ),
        HostCardModel(
            id: "3",
            name: "api-gateway",
            ipAddress: "192.168.0.30",
            status: .warning,
            cpuLoad: 92,
            ramLoad: 76,
            diskLoad: 45
        ),
        HostCardModel(
            id: "4",
            name: "cache-redis-01",
            ipAddress: "192.168.0.40",
            status: .online,
            cpuLoad: 34,
            ramLoad: 56,
            diskLoad: 23
        ),
        HostCardModel(
            id: "5",
            name: "app-server-02",
            ipAddress: "192.168.0.50",
            status: .offline,
            cpuLoad: 0,
            ramLoad: 0,
            diskLoad: 0
        ),
        HostCardModel(
            id: "6",
            name: "worker-node-01",
            ipAddress: "192.168.0.60",
            status: .online,
            cpuLoad: 62,
            ramLoad: 48,
            diskLoad: 31
        ),
        HostCardModel(
            id: "7",
            name: "monitoring-proxy",
            ipAddress: "192.168.0.70",
            status: .warning,
            cpuLoad: 81,
            ramLoad: 79,
            diskLoad: 66
        ),
        HostCardModel(
            id: "8",
            name: "backup-node",
            ipAddress: "192.168.0.80",
            status: .online,
            cpuLoad: 28,
            ramLoad: 44,
            diskLoad: 59
        )
    ]
}
