import Foundation

@MainActor
final class ProblemsViewModel: ObservableObject {
    @Published var selectedFilter: ProblemsFilter = .all
    @Published var problems: [ProblemModel] = []
    @Published var isLoading = false

    var filteredProblems: [ProblemModel] {
        switch selectedFilter {
        case .all:
            return problems
        case .active:
            return problems.filter { $0.status == .active }
        case .resolved:
            return problems.filter { $0.status == .resolved }
        }
    }

    var alertsCountText: String {
        "\(problems.count) алертов"
    }

    func load() async {
        isLoading = true

        try? await Task.sleep(nanoseconds: 300_000_000)
        problems = MockProblemsData.problems

        isLoading = false
    }
}
