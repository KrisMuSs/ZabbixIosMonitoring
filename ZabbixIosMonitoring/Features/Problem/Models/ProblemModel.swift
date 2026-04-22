import Foundation

struct ProblemModel: Identifiable, Hashable {
    let id: String
    let title: String
    let hostName: String
    let timeText: String
    let severity: ProblemSeverityLevel
    let status: ProblemStatus
}

enum ProblemSeverityLevel: String, Hashable {
    case critical = "Критичная"
    case high = "Высокая"
    case warning = "Предупреждение"
    case info = "Информация"
}

enum ProblemStatus: Hashable {
    case active
    case resolved
}

enum ProblemsFilter: String, CaseIterable, Identifiable {
    case all = "Все"
    case active = "Активные"
    case resolved = "Решённые"

    var id: String { rawValue }
}
