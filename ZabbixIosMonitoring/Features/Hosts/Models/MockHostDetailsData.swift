import Foundation

enum MockHostDetailsData {
    static func details(for host: HostCardModel) -> HostDetailsModel {
        switch host.id {
        case "1":
            return HostDetailsModel(
                id: host.id,
                name: host.name,
                ipAddress: host.ipAddress,
                status: host.status,
                cpuLoad: host.cpuLoad,
                ramLoad: host.ramLoad,
                diskLoad: host.diskLoad,
                cpuHistory: sampleCPU1,
                ramHistory: sampleRAM1,
                diskHistory: sampleDisk1,
                activeProblems: []
            )

        case "3":
            return HostDetailsModel(
                id: host.id,
                name: host.name,
                ipAddress: host.ipAddress,
                status: host.status,
                cpuLoad: host.cpuLoad,
                ramLoad: host.ramLoad,
                diskLoad: host.diskLoad,
                cpuHistory: sampleCPU2,
                ramHistory: sampleRAM2,
                diskHistory: sampleDisk2,
                activeProblems: [
                    HostProblem(
                        title: "High CPU usage",
                        subtitle: "2 мин назад",
                        severity: .critical
                    )
                ]
            )

        case "5":
            return HostDetailsModel(
                id: host.id,
                name: host.name,
                ipAddress: host.ipAddress,
                status: host.status,
                cpuLoad: host.cpuLoad,
                ramLoad: host.ramLoad,
                diskLoad: host.diskLoad,
                cpuHistory: [],
                ramHistory: [],
                diskHistory: [],
                activeProblems: [
                    HostProblem(
                        title: "Service unavailable",
                        subtitle: "1 час назад",
                        severity: .critical
                    )
                ]
            )

        default:
            return HostDetailsModel(
                id: host.id,
                name: host.name,
                ipAddress: host.ipAddress,
                status: host.status,
                cpuLoad: host.cpuLoad,
                ramLoad: host.ramLoad,
                diskLoad: host.diskLoad,
                cpuHistory: sampleCPU1,
                ramHistory: sampleRAM1,
                diskHistory: sampleDisk1,
                activeProblems: [
                    HostProblem(
                        title: "SSL certificate expiring",
                        subtitle: "5 часов назад",
                        severity: .warning
                    )
                ]
            )
        }
    }

    static let sampleCPU1: [MetricPoint] = [
        .init(hour: "1:00", value: 45), .init(hour: "3:00", value: 74),
        .init(hour: "5:00", value: 12), .init(hour: "7:00", value: 68),
        .init(hour: "10:00", value: 62), .init(hour: "13:00", value: 87),
        .init(hour: "16:00", value: 8), .init(hour: "18:00", value: 91),
        .init(hour: "20:00", value: 6), .init(hour: "23:00", value: 30)
    ]

    static let sampleRAM1: [MetricPoint] = [
        .init(hour: "1:00", value: 100), .init(hour: "3:00", value: 88),
        .init(hour: "5:00", value: 6), .init(hour: "7:00", value: 14),
        .init(hour: "10:00", value: 95), .init(hour: "13:00", value: 100),
        .init(hour: "16:00", value: 89), .init(hour: "18:00", value: 96),
        .init(hour: "20:00", value: 25), .init(hour: "23:00", value: 4)
    ]

    static let sampleDisk1: [MetricPoint] = [
        .init(hour: "1:00", value: 6), .init(hour: "3:00", value: 67),
        .init(hour: "5:00", value: 8), .init(hour: "7:00", value: 100),
        .init(hour: "10:00", value: 36), .init(hour: "13:00", value: 67),
        .init(hour: "16:00", value: 98), .init(hour: "18:00", value: 23),
        .init(hour: "20:00", value: 55), .init(hour: "23:00", value: 89)
    ]

    static let sampleCPU2: [MetricPoint] = [
        .init(hour: "1:00", value: 32), .init(hour: "3:00", value: 84),
        .init(hour: "5:00", value: 79), .init(hour: "7:00", value: 93),
        .init(hour: "10:00", value: 15), .init(hour: "13:00", value: 7),
        .init(hour: "16:00", value: 95), .init(hour: "18:00", value: 13),
        .init(hour: "20:00", value: 63), .init(hour: "23:00", value: 8)
    ]

    static let sampleRAM2: [MetricPoint] = [
        .init(hour: "1:00", value: 56), .init(hour: "3:00", value: 32),
        .init(hour: "5:00", value: 20), .init(hour: "7:00", value: 86),
        .init(hour: "10:00", value: 7), .init(hour: "13:00", value: 80),
        .init(hour: "16:00", value: 71), .init(hour: "18:00", value: 8),
        .init(hour: "20:00", value: 23), .init(hour: "23:00", value: 55)
    ]

    static let sampleDisk2: [MetricPoint] = [
        .init(hour: "1:00", value: 18), .init(hour: "3:00", value: 66),
        .init(hour: "5:00", value: 32), .init(hour: "7:00", value: 72),
        .init(hour: "10:00", value: 9), .init(hour: "13:00", value: 74),
        .init(hour: "16:00", value: 89), .init(hour: "18:00", value: 6),
        .init(hour: "20:00", value: 94), .init(hour: "23:00", value: 50)
    ]
}
