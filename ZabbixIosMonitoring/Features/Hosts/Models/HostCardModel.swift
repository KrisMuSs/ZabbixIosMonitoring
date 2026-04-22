import Foundation

struct HostCardModel: Identifiable, Hashable {
    let id: String
    let name: String
    let ipAddress: String
    let status: HostStatus
    let cpuLoad: Int
    let ramLoad: Int
    let diskLoad: Int
}

enum HostStatus: Hashable {
    case online
    case warning
    case offline
}
